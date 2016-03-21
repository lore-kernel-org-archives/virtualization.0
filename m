From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 17/18] zsmalloc: migrate tail pages in zspage
Date: Mon, 21 Mar 2016 17:48:25 +0800
Message-ID: <201603211705.9hgJl8K7%fengguang.wu__46494.8907182135$1458553826$gmane$org@intel.com>
References: <1458541867-27380-18-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1458541867-27380-18-git-send-email-minchan@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: aquini@redhat.com, rknize@motorola.com, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Sangseok Lee <sangseok.lee@lge.com>, jlayton@poochiereds.net, koct9i@gmail.com, YiPing Xu <xuyiping@hisilicon.com>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Chan Gyun Jeong <chan.jeong@lge.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, kbuild-all@01.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Minchan,

[auto build test WARNING on next-20160318]
[cannot apply to v4.5-rc7 v4.5-rc6 v4.5-rc5 v4.5]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/Support-non-lru-page-migration/20160321-143339


coccinelle warnings: (new ones prefixed by >>)

>> mm/zsmalloc.c:1103:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
