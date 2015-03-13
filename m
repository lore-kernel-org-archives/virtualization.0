From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
Date: Fri, 13 Mar 2015 14:03:01 +0100
Message-ID: <5502E005.7000406__5953.33353053338$1426251810$gmane$org@redhat.com>
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
	<5501BCF7.9080004@redhat.com>
	<20150312232104.GA32054@ad.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150312232104.GA32054@ad.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



On 13/03/2015 00:21, Fam Zheng wrote:
>> I think the bug here is also that virtio-pci
>> is not defining a .shutdown callback.  It should define one and call
>> free_irq (for INTX) and pci_disable_msix.
> 
> It's not enough. The device has to know we disabled msix, otherwise it will
> send us IRQ, which is wrong.

You can use pci_intx to disable INTX too.  So I think this is a
virtio-pci bug.

Paolo
