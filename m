From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v13 4/5] mm: support reporting free page blocks
Date: Thu, 3 Aug 2017 15:20:09 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73928C971__29724.5719623335$1501793304$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
	<1501742299-4369-5-git-send-email-wei.w.wang@intel.com>
	<20170803091151.GF12521@dhcp22.suse.cz> <5982FE07.3040207@intel.com>
	<20170803104417.GI12521@dhcp22.suse.cz> <59830897.2060203@intel.com>
	<20170803112831.GN12521@dhcp22.suse.cz> <5983130E.2070806@intel.com>
	<20170803124106.GR12521@dhcp22.suse.cz> <59832265.1040805@intel.com>
	<20170803135047.GV12521@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170803135047.GV12521@dhcp22.suse.cz>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday, August 3, 2017 9:51 PM, Michal Hocko: 
> As I've said earlier. Start simple optimize incrementally with some numbers to
> justify a more subtle code.
> --

OK. Let's start with the simple implementation as you suggested.

Best,
Wei
