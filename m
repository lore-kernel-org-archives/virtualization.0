From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH resent] virtio_net: Fix stalled inbound
	trafficon early packets
Date: Wed, 12 Dec 2007 12:27:01 +0100
Message-ID: <200712121227.01828.borntraeger__1758.78685336119$1197458958$gmane$org@de.ibm.com>
References: <200712111242.28843.borntraeger@de.ibm.com>
	<200712111627.21364.borntraeger@de.ibm.com>
	<475F1E86.8000503@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <475F1E86.8000503@qumranet.com>
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
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 12. Dezember 2007 schrieb Dor Laor:
> This is why initially I suggested another status code in order to split 
> the ring logic with driver status.
> > but also not filling any buffers as long as VIRTIO_CONFIG_DEV_OPEN is 
not 
> > set. I will have a look but I think that add_status needs to be called 
> >   
> It can fill the buffers even without dev_open, when the dev is finally 
> opened the host will issue an interrupt if there are pending buffers. 

There is a problem associated with that scheme. Setting the value in the 
config space does not notify the hypervisor. That means the host will not 
send an interrupt. The interrupt is sent if the host tries to send the next 
packet. If somehow the host manages to use up all buffers before the device 
is finally opened, we have a problem.
> (I'm not sure it's worth solving, maybe  just drop them like you 
suggested).
As said above, dropping seems to me the preferred method. Did I miss 
something?

Christian
