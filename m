From: Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger
 random crashes in KVM guests after reboot
Date: Tue, 11 Feb 2020 14:04:54 +0100
Message-ID: <e299afca8e22044916abbf9fbbd0bff6b0ee9e13.camel@redhat.com>
References: <20200107042401-mutt-send-email-mst@kernel.org>
         <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
         <20200107065434-mutt-send-email-mst@kernel.org>
         <fe6e7e90-3004-eb7a-9ed8-b53a7667959f@de.ibm.com>
         <20200120012724-mutt-send-email-mst@kernel.org>
         <2a63b15f-8cf5-5868-550c-42e2cfd92c60@de.ibm.com>
         <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
         <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
         <20200206171349-mutt-send-email-mst@kernel.org>
         <5c860fa1-cef5-b389-4ebf-99a62afa0fe8@de.ibm.com>
         <20200207025806-mutt-send-email-mst@kernel.org>
         <97c93d38-ef07-e321-d133-18483d54c0c0@de.ibm.com>
         <CAJaqyWfngzP4d01B6+Sqt8FXN6jX7kGegjx8ie4no_1Er3igQA@mail.gmail.com>
         <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2020-02-10 at 12:01 +0100, Christian Borntraeger wrote:
> 
> On 10.02.20 10:47, Eugenio Perez Martin wrote:
> > Hi Christian.
> > 
> > I'm not able to reproduce the failure with eccb852f1fe6bede630e2e4f1a121a81e34354ab commit. Could you add more data?
> > Your configuration (libvirt or qemu line), and host's dmesg output if any?
> > 
> > Thanks!
> 
> If it was not obvious, this is on s390x, a big endian system.
> 

Hi Christian. Thank you very much for your fast responses.

Could you try this patch on top of eccb852f1fe6bede630e2e4f1a121a81e34354ab?

Thanks!

From 71d0f9108a18aa894cc0c0c1c7efbad39f465a27 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <
eperezma@redhat.com>
Date: Tue, 11 Feb 2020 13:19:10 +0100
Subject: [PATCH] vhost: fix return value of vhost_get_vq_desc

Before of the batch change, it was the chain's head. Need to keep that
way or we will not be able to free a chain of descriptors.

Fixes: eccb852f1fe6 ("vhost: batching fetches")
---
 drivers/vhost/vhost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b5a51b1f2e79..fc422c3e5c08 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2409,12 +2409,11 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 			*out_num += ret;
 		}
 
-		ret = desc->id;
-
 		if (!(desc->flags & VRING_DESC_F_NEXT))
 			break;
 	}
 
+	ret = vq->descs[vq->first_desc].id;
 	vq->first_desc = i + 1;
 
 	return ret;
-- 
2.18.1
