From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v13 4/5] mm: support reporting free page blocks
Date: Fri, 4 Aug 2017 09:53:37 +0200
Message-ID: <20170804075337.GC26029__8750.14342968843$1501833229$gmane$org@dhcp22.suse.cz>
References: <5982FE07.3040207@intel.com>
	<20170803104417.GI12521@dhcp22.suse.cz>
	<59830897.2060203@intel.com>
	<20170803112831.GN12521@dhcp22.suse.cz>
	<5983130E.2070806@intel.com>
	<20170803124106.GR12521@dhcp22.suse.cz>
	<59832265.1040805@intel.com>
	<20170803135047.GV12521@dhcp22.suse.cz>
	<286AC319A985734F985F78AFA26841F73928C971@shsmsx102.ccr.corp.intel.com>
	<20170804000043-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170804000043-mutt-send-email-mst@kernel.org>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri 04-08-17 00:02:01, Michael S. Tsirkin wrote:
> On Thu, Aug 03, 2017 at 03:20:09PM +0000, Wang, Wei W wrote:
> > On Thursday, August 3, 2017 9:51 PM, Michal Hocko: 
> > > As I've said earlier. Start simple optimize incrementally with some numbers to
> > > justify a more subtle code.
> > > --
> > 
> > OK. Let's start with the simple implementation as you suggested.
> > 
> > Best,
> > Wei
> 
> The tricky part is when you need to drop the lock and
> then restart because the device is busy. Would it maybe
> make sense to rotate the list so that new head
> will consist of pages not yet sent to device?

No, I this should be strictly non-modifying API.
-- 
Michal Hocko
SUSE Labs
