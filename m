From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v20 4/7] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Wed, 03 Jan 2018 17:00:28 +0800
Message-ID: <5A4C9BAC.3040808__49431.9455967799$1514969803$gmane$org@intel.com>
References: <1513685879-21823-5-git-send-email-wei.w.wang@intel.com>	<20171224032121.GA5273@bombadil.infradead.org>	<201712241345.DIG21823.SLFOOJtQFOMVFH@I-love.SAKURA.ne.jp>	<5A3F5A4A.1070009@intel.com>	<20180102132419.GB8222@bombadil.infradead.org>
	<201801031129.JFC18298.FJMHtOFLVSQOFO@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201801031129.JFC18298.FJMHtOFLVSQOFO@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, nilal@redhat.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 01/03/2018 10:29 AM, Tetsuo Handa wrote:
> Matthew Wilcox wrote:
>> The radix tree convention is objectively awful, which is why I'm working
>> to change it.  Specifying the GFP flags at radix tree initialisation time
>> rather than allocation time leads to all kinds of confusion.  The preload
>> API is a pretty awful workaround, and it will go away once the XArray
>> is working correctly.  That said, there's no alternative to it without
>> making XBitmap depend on XArray, and I don't want to hold you up there.
>> So there's an xb_preload for the moment.
> I'm ready to propose cvbmp shown below as an alternative to xbitmap (but
> specialized for virtio-balloon case). Wei, can you do some benchmarking
> between xbitmap and cvbmp?
> ----------------------------------------
> cvbmp: clustered values bitmap

I don't think we need to replace xbitmap, at least at this stage. The 
new implementation doesn't look simpler at all, and virtio-balloon has 
worked well with xbitmap.

I would suggest you to send out the new implementation for discussion 
after this series ends, and justify with better performance results if 
you could get.

Best,
Wei
