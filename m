From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-devel] [virtio-net][PATCH] Don't arm tx hrtimer with a
 constant 500us each transmit
Date: Wed, 12 Dec 2007 16:17:44 +0200
Message-ID: <475FED88.7020304__33471.482669893$1197469184$gmane$org@qumranet.com>
References: <475FD9E8.1060109@qumranet.com>
	<200712121419.50400.borntraeger@de.ibm.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712121419.50400.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, netdev@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
>
> Am Mittwoch, 12. Dezember 2007 schrieb Dor Laor:
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -406,10 +405,10 @@ again:
>
> Hmm, while I agree in general with the patch, I fail to find the proper
> version of virtio_net where this patch applies. I tried kvm.git and
> linux-2.6.git from kernel.org. Can you give me a pointer to the repository
> where you work on virtio?
>
Sorry for that, I added some debug prints of my one.
Here it is: *git clone 
git*://kvm.*qumranet*.com/home/*dor*/src/linux-2.6-nv use branch 'virtio'.
BTW: what git repository do you use?

This patch improves my tx performance from 720Mbps to 900Mbps.
Dor
>
> Christian
>
