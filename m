From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 00/15] ia64/pv_ops take 5
Date: Mon, 19 May 2008 10:52:24 +0900
Message-ID: <20080519015224.GA13212%yamahata__46558.3878722557$1211162078$gmane$org@valinux.co.jp>
References: <12095585682308-git-send-email-yamahata@valinux.co.jp>
	<1FE6DD409037234FAB833C420AA843EC015B26C6@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC015B26C6@orsmsx424.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Dong, Eddie" <eddie.dong@intel.com>, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 16, 2008 at 05:06:21PM -0700, Luck, Tony wrote:
> I started looking at this patch set.

Thank you for your time.


> Parts 1-9 applied ok, but part10 (entry.S) failed to apply because of
> recent changes to this file to fix the problems with warnings when
> trying to get locks with interrupts blocked.
> 
> I thought this would be a good point to test the bisectability
> of this patch set and started a build with just parts 1-9 applied.
> The build was perfectly clean, but the kernel hung during boot
> (possibly when first trying to run user processes by the look
> of the last few messages on the console.

I'll rebase/debug the patches and resend them.
My native case test is done under Xen HVM(full virtualized)
domain.


> The code with parts 1-9 applied still looks readable, but I
> think we may need some documentation later to help with maintainability.

I'll write it. It will be under linux-2.6/Documentation/ia64/.

  
> Perhaps even a tool that can check to make sure people don't add
> direct uses of instructions to .S files that need to be
> paravirtualized.

Yes, I also really want such a tool and I've thought of it.
I want to prevent people from accidently breaking paravirtualization
and only a way to do so would be by enforcing.
I think it can be easily achived by CPP macro trick.
At worst a simple .s (or .o) parser.

-- 
yamahata
