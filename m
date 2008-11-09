From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Sun, 09 Nov 2008 14:53:05 +0200
Message-ID: <4916DD31.4000503__18338.5848803029$1226235348$gmane$org@redhat.com>
References: <20081106154351.GA30459@kroah.com>	<894107.30288.qm@web45108.mail.sp1.yahoo.com>	<20081106164919.GA4099@kroah.com>	<0199E0D51A61344794750DC57738F58E5E26F996C4@GVW1118EXC.americas.hpqcorp.net>	<20081106183630.GD11773@parisc-linux.org>	<491371F0.7020805@codemonkey.ws>
	<87d4h7pnnm.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d4h7pnnm.fsf@basil.nowhere.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "Chiang,
	Alexander" <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Anthony Liguori <anthony@codemonkey.ws>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> Anthony Liguori <anthony@codemonkey.ws> writes:
>   
>> What we would rather do in KVM, is have the VFs appear in the host as
>> standard network devices.  We would then like to back our existing PV
>> driver to this VF directly bypassing the host networking stack.  A key
>> feature here is being able to fill the VF's receive queue with guest
>> memory instead of host kernel memory so that you can get zero-copy
>> receive traffic.  This will perform just as well as doing passthrough
>> (at least) and avoid all that ugliness of dealing with SR-IOV in the
>> guest.
>>     
>
> But you shift a lot of ugliness into the host network stack again.
> Not sure that is a good trade off.
>   

The net effect will be positive.  We will finally have aio networking 
from userspace (can send process memory without resorting to 
sendfile()), and we'll be able to assign a queue to a process (which 
will enable all sorts of interesting high performance things; basically 
VJ channels without kernel involvement).

> Also it would always require context switches and I believe one
> of the reasons for the PV/VF model is very low latency IO and having
> heavyweight switches to the host and back would be against that.
>   

It's true that latency would suffer (or alternatively cpu consumption 
would increase).

-- 
error compiling committee.c: too many arguments to function
