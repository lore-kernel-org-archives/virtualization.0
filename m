From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] vhost: avoid large order allocations
Date: Tue, 13 May 2014 10:57:41 +0200
Message-ID: <20140513105741.0cc3c159__4319.58827325634$1400095243$gmane$org@bee>
References: <1399970133-46783-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1399970133-46783-2-git-send-email-mimu@linux.vnet.ibm.com>
	<20140513084049.GE29442@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140513084049.GE29442@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ddongch@cn.ibm.com, mimu@linux.vnet.ibm.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 13 May 2014 11:40:49 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Please dont' do this, extra indirection hurts performance.
> Instead, please change vhost_net_open and scsi to allocate the whole
> structure with vmalloc if kmalloc fails, along the lines of
> 74d332c13b2148ae934ea94dac1745ae92efe8e5

Thanks for pointing us to: net: extend net_device allocation to vmalloc()

We'll try to adapt.

Michael  
