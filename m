From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] vhost: avoid large order allocations
Date: Tue, 13 May 2014 17:07:31 +0200
Message-ID: <20140513170731.181cc4e3__34488.3846737959$1400095258$gmane$org@bee>
References: <1399970133-46783-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1399970133-46783-2-git-send-email-mimu@linux.vnet.ibm.com>
	<20140513084049.GE29442@redhat.com>
	<87tx8tg3a1.fsf@kima.orebokech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87tx8tg3a1.fsf@kima.orebokech.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Romain Francoise <romain@orebokech.com>
Cc: ddongch@cn.ibm.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 13 May 2014 16:29:58 +0200
Romain Francoise <romain@orebokech.com> wrote:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Please dont' do this, extra indirection hurts performance.
> > Instead, please change vhost_net_open and scsi to allocate the whole
> > structure with vmalloc if kmalloc fails, along the lines of
> > 74d332c13b2148ae934ea94dac1745ae92efe8e5
> 
> Back in January 2013, you didn't seem to think it was a good idea:
> 
> https://lkml.org/lkml/2013/1/23/492
> 

Hi Romain,

in that case I'd suggest that you submit your patch, ours will look pretty much the same!

Cheers
Michael
