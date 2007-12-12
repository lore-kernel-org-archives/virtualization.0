From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [virtio-net][PATCH] Don't arm tx hrtimer with a
	constant 500us each transmit
Date: Wed, 12 Dec 2007 14:19:50 +0100
Message-ID: <200712121419.50400.borntraeger__27516.1338657655$1197465724$gmane$org@de.ibm.com>
References: <475FD9E8.1060109@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <475FD9E8.1060109@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net, dor.laor@qumranet.com
Cc: netdev@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 12. Dezember 2007 schrieb Dor Laor:
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -406,10 +405,10 @@ again:

Hmm, while I agree in general with the patch, I fail to find the proper 
version of virtio_net where this patch applies. I tried kvm.git and 
linux-2.6.git from kernel.org. Can you give me a pointer to the repository 
where you work on virtio?

Christian
