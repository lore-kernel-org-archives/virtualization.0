Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94D14284
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 21:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B28F7436EC
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 21:02:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B28F7436EC
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCkOo5DbqUBn
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 21:02:14 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2FD30436E3
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 21:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FD30436E3
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-29-Sipm66Z9Nfy_PnSYO0hsLg-1; Fri, 29 Dec 2023 20:55:05 +0000
X-MC-Unique: Sipm66Z9Nfy_PnSYO0hsLg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Dec
 2023 20:54:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Dec 2023 20:54:47 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'longman@redhat.com'"
	<longman@redhat.com>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, "'xinhui.pan@linux.vnet.ibm.com'"
	<xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local cpu's
 'node' in the osq_lock() fast path.
Thread-Topic: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local
 cpu's 'node' in the osq_lock() fast path.
Thread-Index: Ado6mUd9raebt4vmQzObd4YJJW0D/g==
Date: Fri, 29 Dec 2023 20:54:47 +0000
Message-ID: <6eacbdbd1e0f489783439af512dc8325@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
In-Reply-To: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

osq_lock() starts by setting node->next to NULL and node->locked to 0.
Careful analysis shows that node->next is always NULL on entry.

node->locked is set non-zero by another cpu to force a wakeup.
This can only happen after the 'prev->next =3D node' assignment,
so locked can be set to zero just before that (along with the assignment
to node->prev).

Only initialise node->cpu once, after that use its value instead
of smp_processor_id() - which is probably a real function call.

Should reduce cache-line bouncing a little.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d414eef4bec6..55f5db896c02 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -51,7 +51,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 =09      struct optimistic_spin_node *prev)
 {
 =09struct optimistic_spin_node *next =3D NULL;
-=09int curr =3D encode_cpu(smp_processor_id());
+=09int curr =3D node->cpu;
 =09int old;
=20
 =09/*
@@ -98,12 +98,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 {
 =09struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
 =09struct optimistic_spin_node *prev, *next;
-=09int curr =3D encode_cpu(smp_processor_id());
 =09int old;
=20
-=09node->locked =3D 0;
-=09node->next =3D NULL;
-=09node->cpu =3D curr;
+=09if (unlikely(node->cpu =3D=3D OSQ_UNLOCKED_VAL))
+=09=09node->cpu =3D encode_cpu(smp_processor_id());
=20
 =09/*
 =09 * We need both ACQUIRE (pairs with corresponding RELEASE in
@@ -111,12 +109,13 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09 * the node fields we just initialised) semantics when updating
 =09 * the lock tail.
 =09 */
-=09old =3D atomic_xchg(&lock->tail, curr);
+=09old =3D atomic_xchg(&lock->tail, node->cpu);
 =09if (old =3D=3D OSQ_UNLOCKED_VAL)
 =09=09return true;
=20
 =09prev =3D decode_cpu(old);
 =09node->prev =3D prev;
+=09node->locked =3D 0;
=20
 =09/*
 =09 * osq_lock()=09=09=09unqueue
@@ -214,7 +213,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 void osq_unlock(struct optimistic_spin_queue *lock)
 {
 =09struct optimistic_spin_node *node, *next;
-=09int curr =3D encode_cpu(smp_processor_id());
+=09int curr =3D raw_cpu_read(osq_node.cpu);
=20
 =09/*
 =09 * Fast path for the uncontended case.
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

