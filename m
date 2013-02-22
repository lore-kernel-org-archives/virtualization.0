From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 10:24:48 -0800
Message-ID: <201302221825.r1MIOx7d027151__11142.7006581382$1361644769$gmane$org@mail.zytor.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<20130222165531.GA29308@phenom.dumpdata.com>
	<5127A719.3060702@zytor.com>
	<20130222173805.GC7768@phenom.dumpdata.com>
	<alpine.DEB.2.02.1302221804340.22997@kaball.uk.xensource.com>
	<CAE9FiQV8U-7rZZU4Uj_3MVRZiFeq3uEW0ErmCuy1m8AE55gxfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAE9FiQV8U-7rZZU4Uj_3MVRZiFeq3uEW0ErmCuy1m8AE55gxfw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Gokul Caushik <caushik1@gmail.com>, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@elte.hu>, Borislav Petkov <bp@suse.de>, Alexander Duyck <alexander.h.duyck@intel.com>, "H. J. Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jamie.Lokier@zytor.com, "Rafael J. Wysocki" <rjw@sisk.pl>, Borislav Petkov <bp@alien8.de>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Daniel J Blueman <daniel@numascale-asia.com>, Jacob Shin <jacob.shin@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, H. Peter Anvin
List-Id: virtualization@lists.linuxfoundation.org

<jamie@shareable.org>,Jarkko Sakkinen <jarkko.sakkinen@intel.com>,Jeremy Fitzhardinge <jeremy@goop.org>,Joe Millenbach <jmillenbach@gmail.com>,Joerg Roedel <joro@8bytes.org>,Johannes Weiner <hannes@cmpxchg.org>,Josh Triplett <josh@joshtriplett.org>,Kyungmin Park <kyungmin.park@samsung.com>,Lee Schermerhorn <Lee.Schermerhorn@hp.com>,Len Brown <len.brown@intel.com>,Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,Marcelo Tosatti <mtosatti@redhat.com>,Marek Szyprowski <m.szyprowski@samsung.com>,Matt Fleming <matt.fleming@intel.com>,Mel Gorman <mgorman@suse.de>,Paul Turner <pjt@google.com>,Pavel Machek <pavel@ucw.cz>,Pekka Enberg <penberg@kernel.org>,Peter Zijlstra <a.p.zijlstra@chello.nl>,Ralf Baechle <ralf@linux-mips.org>,Rik van Riel <riel@redhat.com>,Rob Landley <rob@landley.net>,R
 ussell King <linux@arm.linux.org.uk>,Rusty Russell <rusty@rustcorp.com.au>,Shuah Khan <shuah.khan@hp.com>,Shuah Khan <shuahkhan@gmail.com>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixn!
 er
<tglx@linutronix.de>,=?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,Zachary Amsden <zamsden@gmail.com>,"avi@redhat.com" <avi@redhat.com>,"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,"mst@redhat.com" <mst@redhat.com>,"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Message-ID: <1b89b5cf-4ad4-4c25-ab76-a8ac6910c2ec@email.android.com>

Again... you probably want to check into Dave's debug changes first. Makes more sense.

Yinghai Lu <yinghai@kernel.org> wrote:

>On Fri, Feb 22, 2013 at 10:06 AM, Stefano Stabellini
><stefano.stabellini@eu.citrix.com> wrote:
>> On Fri, 22 Feb 2013, Konrad Rzeszutek Wilk wrote:
>>> On Fri, Feb 22, 2013 at 09:12:57AM -0800, H. Peter Anvin wrote:
>>> > On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
>>> > >
>>> > >What is bizzare is that I do recall testing this (and Stefano
>also did it).
>>> > >So I am not sure what has altered.
>>> > >
>>> >
>>> > Yes, there was a very specific reason why I wanted you guys to
>test it...
>>>
>>> Exactly. And I re-ran the same test, but with a new kernel. This is
>what
>>> git reflog tells me:
>>>
>>> 473cd24 HEAD@{75}: checkout: moving from
>08f321ed97353cf3b3fafa6b1c1971d6a8970830 to linux-next
>>> 08f321e HEAD@{76}: checkout: moving from linux-next to
>yinghai/for-x86-mm
>>> eb827a7 HEAD@{77}: checkout: moving from
>1b66ccf15ff4bd0200567e8d70446a8763f96ee7 to linux-next
>>> [konrad@build linux]$ git show 08f321e
>>> commit 08f321ed97353cf3b3fafa6b1c1971d6a8970830
>>> Author: Yinghai Lu <yinghai@kernel.org>
>>> Date:   Thu Nov 8 00:00:19 2012 -0800
>>>
>>>     mm: Kill NO_BOOTMEM version free_all_bootmem_node()
>>>
>>> And I recall Stefano later on testing (I was in a conference and did
>not have
>>> the opportunity to test it). Not sure what he ran with.
>>>
>>
>> FYI the last patch series I tested was Yinghai's "x86, boot, 64bit:
>Add
>> support for loading ramdisk and bzImage above 4G" v7u1.
>
>
>the one in tip and linus's tree is
>---
>-v7u2: update changelog and comments, and clear more fields for
>sentinel.
>     Update swiotlb autoswitch off patch.
>     Fix crash with xen PV guest with 2G.
>---
>
>and it fixes xen crash that you reported with v7u1, and you tested
>that add-on patch
>fix_xen_2g.patch with v7u1.
>and I fold the addon patch into offending patch in v7u2.
>
>
>Thanks
>
>Yinghai

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
