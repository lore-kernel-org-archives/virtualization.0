From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 00/15] ia64/pv_ops take 5
Date: Fri, 16 May 2008 17:06:21 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC015B26C6__43451.3996042826$1210982954$gmane$org@orsmsx424.amr.corp.intel.com>
References: <12095585682308-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <12095585682308-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, linux-ia64@vger.kernel.org
Cc: xen-ia64-devel@lists.xensource.com, "Dong, Eddie" <eddie.dong@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I started looking at this patch set.

Parts 1-9 applied ok, but part10 (entry.S) failed to apply because of
recent changes to this file to fix the problems with warnings when
trying to get locks with interrupts blocked.

I thought this would be a good point to test the bisectability
of this patch set and started a build with just parts 1-9 applied.
The build was perfectly clean, but the kernel hung during boot
(possibly when first trying to run user processes by the look
of the last few messages on the console.

The code with parts 1-9 applied still looks readable, but I
think we may need some documentation later to help with maintainability.
Perhaps even a tool that can check to make sure people don't add
direct uses of instructions to .S files that need to be
paravirtualized.

I'm talking to some of the virtualization people here to
see if they can help me set up a system so that I will be
able to test out the non-native execution paths.

-Tony
