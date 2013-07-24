From: Shuah Khan <shuahkhan@gmail.com>
Subject: Re: Linux Plumbers ACPI/PM, PCI Microconference
Date: Wed, 24 Jul 2013 10:30:33 -0600
Message-ID: <CAKocOOOW6+eqb6GTsWLgonQQ7uy5R10t6L_T3jaTN9qSbetVeQ__35539.3231184737$1374683446$gmane$org@mail.gmail.com>
References: <CAL-B5D03ki8NHsM6EuESTH2K-Eh+XyFHNXPDYwgDq+oagDjtMQ@mail.gmail.com>
	<CAErSpo7TexM5-7Z=8H+B5=49-GzoKd_prn=LbMFZWV9rpdn__A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAErSpo7TexM5-7Z=8H+B5=49-GzoKd_prn=LbMFZWV9rpdn__A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Myron Stowe <myron.stowe@gmail.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 23, 2013 at 10:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jul 16, 2013 at 8:21 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
>> Linux Plumbers has approved an ACPI/PM, PCI microconference. The
>> overview page is here:
>>
>> http://wiki.linuxplumbersconf.org/2013:pci_subsystem
>>
>> We would like to start receiving volunteers for presenting topics of
>> interest.  There is a lot of activity in these subsystems so please
>> respond by submitting presentation or discussion proposals that you
>> would be willing to cover for consideration.  You should also feel
>> free to submit ideas as proposals that others could cover.
>
> Somebody else privately suggested these ARM/PCI topics:
>
>> -> how it's been cleaned up to be more common across arm-32 machines
>> -> dependencies on dtb
>> -> future use/dependency(s) on ACPI
>> -> hotplug support issues (if any; acpi (host-bridge) vs <whatever ARM uses> ?)
>
> and I'm interested in those as well.  There seems to be a lot of
> activity in that area.  In addition, I'm interested in ARM IOMMU
> support.  I see drivers/iommu/arm-smmu.c, but it's brand-new and I
> haven't looked at it at all.
>

I second this topic. I am interested in ARM/iommu space also.

thanks,
-- Shuah
