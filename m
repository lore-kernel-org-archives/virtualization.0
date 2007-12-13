From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-devel] [virtio-net][PATCH] Don't arm tx hrtimer with a
 constant 500us each transmit
Date: Thu, 13 Dec 2007 10:44:26 +0200
Message-ID: <4760F0EA.7010004__9369.47779632664$1197535615$gmane$org@qumranet.com>
References: <475FD9E8.1060109@qumranet.com>
	<200712121419.50400.borntraeger@de.ibm.com>
	<475FED88.7020304@qumranet.com>
	<200712121733.07804.borntraeger@de.ibm.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712121733.07804.borntraeger@de.ibm.com>
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
> > Christian Borntraeger wrote:
> > >
> > > Am Mittwoch, 12. Dezember 2007 schrieb Dor Laor:
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -406,10 +405,10 @@ again:
> > >
> > > Hmm, while I agree in general with the patch, I fail to find the 
> proper
> > > version of virtio_net where this patch applies. I tried kvm.git and
> > > linux-2.6.git from kernel.org. Can you give me a pointer to the
> repository
> > > where you work on virtio?
> > >
> > Sorry for that, I added some debug prints of my one.
> > Here it is: *git clone
> > git*://kvm.*qumranet*.com/home/*dor*/src/linux-2.6-nv use branch 
> 'virtio'.
>
> Ah, ok. I will look into that branch.
>
> > BTW: what git repository do you use?
>
> I use Avis git from kernel.org:
> git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm
>
I patch it with Anthony's http://hg.codemonkey.ws/linux-virtio/
Over that I send the patches. One can use my repository directly.
>
> Christian
>
