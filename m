From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] mm/page_poison: move PAGE_POISON to page_poison.c
Date: Mon, 26 Feb 2018 12:37:58 +0800
Message-ID: <5A938F26.4040901@intel.com>
References: <1518163694-27155-1-git-send-email-wei.w.wang@intel.com>
	<20180213101615.GO3443@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180213101615.GO3443@dhcp22.suse.cz>
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
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/13/2018 06:16 PM, Michal Hocko wrote:
> On Fri 09-02-18 16:08:14, Wei Wang wrote:
>> The PAGE_POISON macro is used in page_poison.c only, so avoid exporting
>> it. Also remove the "mm/debug-pagealloc.c" related comment, which is
>> obsolete.
> Why is this an improvement? I thought the whole point of poison.h is to
> keep all the poison value at a single place to make them obviously
> unique.

There isn't a comment explaining why they are exposed. We did this 
because PAGE_POISON is used by page_poison.c only, it seems not 
necessary to expose the private values.
Why would it be not unique if moved to page_poison.c (on condition that 
it is only used there)?

Best,
Wei
