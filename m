From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [RFC-v2 0/4] tcm_vhost+cmwq fabric driver code for-3.6
Date: Wed, 18 Jul 2012 20:12:23 +0000
Message-ID: <3F0FFDE7-B463-42B3-A812-2980FC0DD2C6__17429.9989980229$1342642357$gmane$org@intel.com>
References: <1342041304-29728-1-git-send-email-nab@linux-iscsi.org>
	<20120717150548.GA11587@redhat.com> <5005B52E.20509@us.ibm.com>
	<1342561819.18004.470.camel@haakon2.linux-iscsi.org>
	<5006BD3D.7090104@us.ibm.com> <20120718155338.GA21817@infradead.org>
	<20120718160015.GH1777@redhat.com>
	<4872F2B9-F952-48C9-9724-D30239ACD989@intel.com>
	<20120718171722.GA2347@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120718171722.GA2347@redhat.com>
Content-Language: en-US
Content-ID: <028FC98CC55FA842A182FFD93AF313C7@intel.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, Anthony Liguori <aliguori@us.ibm.com>, kvm-devel <kvm@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Jul 18, 2012, at 10:17 AM, Michael S. Tsirkin wrote:

<snip>

>> You do have to pay very close attention to some things however. Don't change the device identity in any way - even version information, otherwise a Windows initiator will blue-screen. I made that mistake myself, so I remember it well. It seemed like such an innocent change. I don't recall there being any issue with adding commands and we did do that on occasion.
> 
> How about removing commands?

Good question. With the storage system I am familiar with, that would only be a risk if firmware were downgraded. Downgrading would never have been recommended. I am sure that if something like persistent reserve suddenly went away it would cause big trouble for some initiators.

-- 
Mark Rustad, LAN Access Division, Intel Corporation
