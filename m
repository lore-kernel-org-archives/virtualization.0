From: Andi Kleen <andi@firstfloor.org>
Subject: Re: PV DMA for PCI passthrough devices for KVM
Date: Tue, 29 Apr 2008 15:15:24 +0200
Message-ID: <87skx4hker.fsf__11048.2265161865$1209475177$gmane$org@basil.nowhere.org>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com> (Amit
	Shah's message of "Tue, 29 Apr 2008 13:37:28 +0300")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@qumranet.com> writes:

> This patchset implements PVDMA for handling DMA requests from
> devices assigned to the guest from the host machine.

You forgot to post a high level design overview of how this works,
what it is good for, what are the design trade offs etc.? 

Include that in the first patch.

-Andi
