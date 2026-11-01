Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499883;
	b=zxh6k+6VloLDDEXJyPfEqCPFPGmieMZfI64xsMBzAjGiwkHclyJTrARZ7tpI+gunkbb7
	 DePlYoGYbVPDMKB36ohvou1fR6aioB92AmGpwyWz5syhl7SQ0Ha22BvmG9Z8wP515Izj5
	 JjoVWRRiXByhwIGRwlKWWDuQYhcHIr3pXKXuL/quU9fWsv/7bwXwGsR52dm+EHn4bv9Tu
	 Cc3RiBnyvEnJs6qv10fntJpEW3wBpt0UKhLjSoDvdMu4hU8xsEd2sG6ilfOSqGhEAxg5k
	 bcMBlhaXct9spjpI2kitpnxhNhfS2tGUj4o6lwVt0Rs94uVUn33uv3nAyhyvRPAIH0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499883;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=9qK/M5Q1l5Xw9YVuAHPCYT0d7+vzZiNxXyZrRyF08os=;
	b=Y4/jLT1XrupDM6pAfapJHunsIJx+yY2YPMVSgUBJzMKYl10Uhv2LM0KiqRRyJuugFcIg
	 y7Y3Ycft+dQ4VrQeUEZ/vMlqtMuhmKm+ozjbnNNZKee6wlOU1PTItQoYAJ5L/f5LzbygB
	 P6gLed3O9v7M89AZrtjHUF0UHz4nSMcoCn8a4z0iM1AdNYJpQd2+VCjB5B+6Rxl/YtFPO
	 ODVHWNzSG/giptG/aBoG7h49WVI9ct1FVHTiy8sP/ZkQN9ZAkIuQM3zYO9iWgvdMPWWwk
	 FePfoKZAOQfz5HXvlsLQsGNcuePcBI4bvksWd/b7+u5fbY7YwlJfjpD0owduDJBUVeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dWhEKt8X;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054D606A32C
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 02:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7054D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dWhEKt8X
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A120UWO2808260
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 19:24:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=9qK/M5Q1l
	5Xw9YVuAHPCYT0d7+vzZiNxXyZrRyF08os=; b=dWhEKt8XEnbeg/CG6qT1Sfbn+
	RwHUjzspdgTbP2trmunhDRXjOyLxmG1OgZK1BSC0bJqkzmStVm1+YVW/I3+RfTOS
	1ZjFn62pxhFkoMI2CBzMM1d3ZtwaC8WFRruMBsidYyEVh6KeaUnwB8hDwEw8srEe
	HLQYq4FHx2Mi6Yiwu6z2Jk663/DPWyUpHrcbVkpDom4mWyXKzUjwV1IBhrbJz7ht
	haJGnIt/WYSXl8CroG5vCgNALUNykTrjcPSL/vrzHh1PzUW0FqtVZV3rVU+645Ze
	LaDJ7YWMze6QFIaIQ0sKYhqp7GO1WZO1lnlTv1z6DQAaVLUvlAyrc/MR/Uw+Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hn2wddm10-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 19:24:40 -0700 (PDT)
Received: from twshared30277.33.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Sun, 1 Nov 2026 02:24:39 +0000
Received: by devvm18200.frc0.facebook.com (Postfix, from userid 352338)
	id 153296E473AD3; Sat, 31 Oct 2026 19:24:37 -0700 (PDT)
From: Foo Bar <muratseker@meta.com>
To: Amit Shah <amit@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <muratseker@meta.com>
Subject: [PATCH] virtio_console: add console port to list before hvc_alloc()
Date: Sat, 31 Oct 2026 19:24:35 -0700
Message-ID: <20261101022435.3466820-1-muratseker@meta.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cp9YpvENq0BtA43AA_THiNLK_cVyDzlX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAwOSBTYWx0ZWRfX4EgHnCB23U7l
 /IyXd/py6wymB4XJpI8N1FaeCL84LESuZQMeS5aSE/+405nTL2KyqnVPMqZixWwVnEkXkzUIpYg
 bjlDhYWcX5kv8ipGhiHQShStKYOn77Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAwOSBTYWx0ZWRfX8Bwx/dPGecdJ
 lLytz3oE09bAKq84TIT5Al1kTl9nAkvaxtXi8b+utpfUOBSW3U3+1Qvc2XHB98s0R3JZ9EJAtXA
 wgqCzt3G5mcfr8LUsaUmLdjH+381Ba9QYhB1xgItvJsnOgkyaYEEGlJoJHKbPWIO4lX8LNg8D32
 An3W8Mr1to3pecG4zHKO06/p92ZebhwrsHx8ieitPITkDuRbFPtwn0yXwu4Fpe05lRyvsH3oGSo
 pVX/BA6e3Yi4mqg7pUT5hs0yKdQFZzIlIezsrTyOQlRtlUoT9zxeoAcDxNmiGzZrpfUhRnMMa9D
 9ar4+L47Ifgrs5HrKRISJSymWSmzm9TBEvN1W+20AwYfeKtjS10nRtQ3d4EAbBBXQzkIuZ9rwru
 tdIqjNbv0QfMH1BgDes2r6PGUQ0zOC/5/d2j/+jrRMvinZNVCOGFswaq5M2jGCYY1bEyvQWl+EL
 Bohx5g7Mc1YZlWKTcxQ==
X-Authority-Analysis: v=2.4 cv=U+MHnuru c=1 sm=1 tr=0 ts=6ae6a2e8 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=3OxQIUvJTM31TIZw88YA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: cp9YpvENq0BtA43AA_THiNLK_cVyDzlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_01,2026-10-21_02,2025-10-01_01

From: Murat Seker <muratseker@meta.com>

init_port_console() calls hvc_alloc() before adding the port to
pdrvdata.consoles.  When the port is the preferred console (for example
console=3Dhvc0), hvc_alloc() registers it, and register_console() replays
the log buffer through put_chars().  put_chars() looks the port up by
vtermno in pdrvdata.consoles, does not find it yet and returns -EPIPE,
so hvc discards every message printed before virtio-console probed.
The messages are still in the kernel log, but a host capturing the
virtio console never receives them.

Add the port to the list before calling hvc_alloc(), and remove it again
if hvc_alloc() fails.  The out_vq, outvq_lock and portdev used by
put_chars() are set up in add_port() before init_port_console() runs,
and the other users of cons.hvc check it through is_console_port().

Tested on x86_64 QEMU/KVM with KASAN, PROVE_LOCKING and DEBUG_LIST:
with console=3Dhvc0 the virtio console now starts at [0.000000] instead o=
f
at virtio-console probe; with hvc0 next to ttyS0 both carry the full
log; with earlycon (no replay) output is unchanged; and hot-adding and
removing extra virtconsole ports still works.  No new warnings.

Fixes: 38edf58d73c2 ("virtio: console: don't assume a single console port=
.")
Signed-off-by: Murat Seker <muratseker@meta.com>
---
 drivers/char/virtio_console.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.=
c
index 019bcae81af5..a31fdac65891 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1280,18 +1280,28 @@ static int init_port_console(struct port *port)
 		return ret;
=20
 	port->cons.vtermno =3D ret;
+
+	/*
+	 * hvc_alloc() may register the console, which replays the log buffer
+	 * through put_chars().  put_chars() finds the port on this list, so
+	 * add it first or the replayed messages are dropped.
+	 */
+	spin_lock_irq(&pdrvdata_lock);
+	list_add_tail(&port->cons.list, &pdrvdata.consoles);
+	spin_unlock_irq(&pdrvdata_lock);
+
 	port->cons.hvc =3D hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE)=
;
 	if (IS_ERR(port->cons.hvc)) {
 		ret =3D PTR_ERR(port->cons.hvc);
 		dev_err(port->dev,
 			"error %d allocating hvc for port\n", ret);
 		port->cons.hvc =3D NULL;
+		spin_lock_irq(&pdrvdata_lock);
+		list_del(&port->cons.list);
+		spin_unlock_irq(&pdrvdata_lock);
 		ida_free(&vtermno_ida, port->cons.vtermno);
 		return ret;
 	}
-	spin_lock_irq(&pdrvdata_lock);
-	list_add_tail(&port->cons.list, &pdrvdata.consoles);
-	spin_unlock_irq(&pdrvdata_lock);
 	port->guest_connected =3D true;
=20
 	/* Notify host of port being opened */
--=20
2.53.0-Meta

