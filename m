From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RESEND] mm: don't zero ballooned pages
Date: Mon, 7 Aug 2017 11:37:26 +0200
Message-ID: <8b862c93-1a9f-9247-8401-5092cc35a857__41932.706864509$1502098693$gmane$org@redhat.com>
References: <1501761557-9758-1-git-send-email-wei.w.wang@intel.com>
	<9ac31505-0996-2822-752e-8ec055373aa0@redhat.com>
	<20170807092525.GE32434@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170807092525.GE32434@dhcp22.suse.cz>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, mst@redhat.com, mawilcox@microsoft.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, zhenwei.pi@youruncloud.com
List-Id: virtualization@lists.linuxfoundation.org

> Maybe it is my absolute lack of familiarity with what the host actually
> does with balloon pages but I fail to see why the above matters at all.
> ksm will not try to merge sub page units (4k for hugetlb or a large base
> page). And if you need to hide the guest contents then the host can
> clear the respective subpage just fine. So could you be more explicit
> why MADV_DONTNEED matters at all? Also does any host actually share sub
> pages between different guests? This sounds like a bad idea to me in
> general.
> 

Okay, I think I got the issue wrong. I thought that the original patch
tried to also fix a corner case where the guest would assume that it
would get supplied zero pages afterwards. Please ignore the noise. :)

-- 

Thanks,

David
