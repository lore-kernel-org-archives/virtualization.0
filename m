From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Sat, 04 Oct 2008 11:53:19 +0300
Message-ID: <48E72EFF.5040101__44612.5674447559$1223110595$gmane$org@redhat.com>
References: <1222881242.9381.17.camel@alok-dev1>	 <48E3B19D.6060905@zytor.com>
	<1222882431.9381.23.camel@alok-dev1>	 <48E3BC21.4080803@goop.org>
	<1222895153.9381.69.camel@alok-dev1> <48E3FDD5.7040106@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15D927EA4@orsmsx505.amr.corp.intel.com>
	<48E422CA.2010606@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DCBA221@orsmsx505.amr.corp.intel.com>
	<48E6AB15.8060405@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DCBA325@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0B53E02A2965CE4F9ADB38B34501A3A15DCBA325@orsmsx505.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "akataria@vmware.com" <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> What's the significance of supporting multiple interfaces to the same guest simultaneously, i.e. _runtime_? We don't want the guests to run on such a literarily Frankenstein machine. And practically, such testing/debugging would be good only for Halloween :-).
>
>   

If you can only expose one interface, you need to have the user choose.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
