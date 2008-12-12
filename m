From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/4] s390: remove s390_root_dev_*()
Date: Fri, 12 Dec 2008 10:29:51 +0100
Message-ID: <20081212102951.01446f22__7460.99501052431$1229074407$gmane$org@gondolin>
References: <1229012203.7968.79.camel@blaa>
	<1229012216-4211-1-git-send-email-markmc@redhat.com>
	<1229012216-4211-2-git-send-email-markmc@redhat.com>
	<1229012216-4211-3-git-send-email-markmc@redhat.com>
	<1229012216-4211-4-git-send-email-markmc@redhat.com>
	<20081211180025.045b9b4a@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081211180025.045b9b4a@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: linux-s390@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 11 Dec 2008 18:00:25 +0100,
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Thu, 11 Dec 2008 16:16:56 +0000,
> Mark McLoughlin <markmc@redhat.com> wrote:
> 
> > Replace s390_root_dev_register() with root_device_register() etc.
> 
> Nice, one more special case generalized :) I'll give it a run.

You missed one occurrence in iucv (see below); with that patch applied,
everything seems to work as expected, both for root devices created by
built-ins and by modules.

---
 net/iucv/iucv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/net/iucv/iucv.c
+++ linux-2.6/net/iucv/iucv.c
@@ -1682,7 +1682,7 @@ static void __exit iucv_exit(void)
 		kfree(iucv_irq_data[cpu]);
 		iucv_irq_data[cpu] = NULL;
 	}
-	s390_root_dev_unregister(iucv_root);
+	root_device_unregister(iucv_root);
 	bus_unregister(&iucv_bus);
 	unregister_external_interrupt(0x4000, iucv_external_interrupt);
 }
