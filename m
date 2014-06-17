From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Tue, 17 Jun 2014 11:44:11 +0200
Message-ID: <53A00DEB.8030400@redhat.com>
References: <20140610184818.2e490419@nbschild1>	<53978375.6090707@6wind.com>	<87ppie1v4r.fsf@blackfin.pond.sub.org>	<20140612094413.15e56938@nbschild1>	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>	<5399CF09.8030803@6wind.com>	<87ppidnqmy.fsf@blackfin.pond.sub.org>	<539AC3E0.9090404@6wind.com>	<539ACDE6.7020709@redhat.com>	<539AFF7C.7090702@6wind.com>	<539B064D.2050501@redhat.com>
	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
	<53A00464.8090609@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A00464.8090609@6wind.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Marchand <david.marchand@6wind.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Vincent JARDIN <vincent.jardin@6wind.com>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 17/06/2014 11:03, David Marchand ha scritto:
>> Unless someone steps up and maintains ivshmem, I think it should be
>> deprecated and dropped from QEMU.
>
> Then I can maintain ivshmem for QEMU.
> If this is ok, I will send a patch for MAINTAINERS file.

Typically, adding yourself to maintainers is done only after having 
proved your ability to be a maintainer. :)

So, let's stop talking and go back to code!  You can start doing what 
was suggested elsewhere in the thread: get the server and uio driver 
merged into the QEMU tree, document the protocol in 
docs/specs/ivshmem_device_spec.txt, and start fixing bugs such as the 
ones that Markus reported.

Since ivshmem is basically KVM-only (it has a soft dependency on 
ioeventfd), CC the patches to kvm@vger.kernel.org and I'll merge them 
via the KVM tree for now.  I'll (more than) gladly give maintainership 
away in due time.

Paolo
