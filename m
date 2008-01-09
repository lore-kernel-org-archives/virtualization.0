From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH/RFC 0/2] CPU hotplug virtio driver
Date: Wed, 9 Jan 2008 12:27:12 +0100
Message-ID: <200801091227.12261.borntraeger__23670.768706552$1199878233$gmane$org@de.ibm.com>
References: <11998740663306-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11998740663306-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: virtualization@lists.linux-foundation.org, marcelot@redhat.com, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 9. Januar 2008 schrieb Glauber de Oliveira Costa:
> I'm sending a first draft of my proposed cpu hotplug driver for kvm/virtio
> The first patch is the kernel module, while the second, the userspace pci 
device.

I personally prefer to use non paravirtualized cpu hotplug and implement the 
existing interfaces instead in the hypervisor. (sigp/sclp for s390 and 
maybe acpi for x86 etc.). This is not a performance critical operation.


Christian
