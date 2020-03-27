From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v2 00/10] virtio-mem: paravirtualized memory
Date: Fri, 27 Mar 2020 17:58:24 +0100
Message-ID: <CAM9Jb+g6DEL1=L1ESfW+Jnr_rfO5rEtOwnp10eCLpajaAv8wvg@mail.gmail.com>
References: <20200311171422.10484-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200311171422.10484-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi David,

Trying to test the series with the Qemu branch(virtio-mem) mentioned.
Unfortunately,
not able to hotplug memory. Is anything changed from your previous posting
or I am doing something wrong?

After giving value to "requested-size", I see size as zero.

(qemu) qom-set vm0 requested-size 10G
(qemu) info memory-devices
Memory device [virtio-mem]: "vm0"
  memaddr: 0x240000000
  node: 0
  requested-size: 10737418240
  size: 0
  max-size: 107374182400
  block-size: 2097152
  memdev: /objects/mem0

Guest kernel: 5.6.0-rc4
Using same Qemu commandline arguments mentioned in cover-letter.

Thanks,
Pankaj
