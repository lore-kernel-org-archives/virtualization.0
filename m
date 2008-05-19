From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 00/15] ia64/pv_ops take 5
Date: Mon, 19 May 2008 08:46:14 +0100
Message-ID: <48313046.6030602__10492.7900749773$1211183317$gmane$org@goop.org>
References: <12095585682308-git-send-email-yamahata@valinux.co.jp>	<1FE6DD409037234FAB833C420AA843EC015B26C6@orsmsx424.amr.corp.intel.com>
	<20080519015224.GA13212%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080519015224.GA13212%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, "Dong,
	Eddie" <eddie.dong@intel.com>, virtualization@lists.linux-foundation.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> Yes, I also really want such a tool and I've thought of it.
> I want to prevent people from accidently breaking paravirtualization
> and only a way to do so would be by enforcing.
> I think it can be easily achived by CPP macro trick.
> At worst a simple .s (or .o) parser.
>   

For what its worth, this hasn't been a problem on x86 at all.  All the 
"interesting" instructions are used via macros/inline functions, and 
there have been no instances (that I know of, at least) of naked ones 
appearing anywhere.  And all the gatekeeper maintainers are definitely 
aware of the paravirt constraints, so I don't think any would make it 
past review.

    J
