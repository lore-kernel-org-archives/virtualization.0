From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 10:08:22 -0800
Message-ID: <CAE9FiQXWyD_Fe_6OnLg13ReANM=43J76BFif9obLjBHtzzY8Ew@mail.gmail.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<20130222165531.GA29308@phenom.dumpdata.com>
	<5127A719.3060702@zytor.com>
	<20130222173805.GC7768@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130222173805.GC7768@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-mips@linux-mips.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. J. Lu" <hjl.tools@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization@lists.linux-foundation.org, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, linux-pm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Yasuaki Ishimatsu <isimatu.yasuaki@j>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 22, 2013 at 9:38 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Fri, Feb 22, 2013 at 09:12:57AM -0800, H. Peter Anvin wrote:
>> On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
>> >
>> >What is bizzare is that I do recall testing this (and Stefano also did it).
>> >So I am not sure what has altered.
>> >
>>
>> Yes, there was a very specific reason why I wanted you guys to test it...
>
> Exactly. And I re-ran the same test, but with a new kernel. This is what
> git reflog tells me:
>
> 473cd24 HEAD@{75}: checkout: moving from 08f321ed97353cf3b3fafa6b1c1971d6a8970830 to linux-next
> 08f321e HEAD@{76}: checkout: moving from linux-next to yinghai/for-x86-mm
> eb827a7 HEAD@{77}: checkout: moving from 1b66ccf15ff4bd0200567e8d70446a8763f96ee7 to linux-next
> [konrad@build linux]$ git show 08f321e
> commit 08f321ed97353cf3b3fafa6b1c1971d6a8970830
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Thu Nov 8 00:00:19 2012 -0800
>
>     mm: Kill NO_BOOTMEM version free_all_bootmem_node()
>
> And I recall Stefano later on testing (I was in a conference and did not have
> the opportunity to test it). Not sure what he ran with.

the commit in tip and linus tree have different hash...

commit 600cc5b7f6371706679490d7ee108015ae57ac2f
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Fri Nov 16 19:39:22 2012 -0800

    mm: Kill NO_BOOTMEM version free_all_bootmem_node()

    Now NO_BOOTMEM version free_all_bootmem_node() does not really
    do free_bootmem at all, and it only call register_page_bootmem_info_node
    for online nodes instead.
