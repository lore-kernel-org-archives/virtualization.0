From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Wed, 18 Jun 2014 17:10:12 +0200
Message-ID: <53A1ABD4.3000607@redhat.com>
References: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
	<53A00464.8090609@6wind.com> <53A00DEB.8030400@redhat.com>
	<20140618104849.GH14030@stefanha-thinkpad.redhat.com>
	<53A1A8BE.3000801@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A1A8BE.3000801@6wind.com>
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
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, Claudio Fontana <claudio.fontana@huawei.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Vincent JARDIN <vincent.jardin@6wind.com>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 18/06/2014 16:57, David Marchand ha scritto:
> Hello Stefan,
>
> On 06/18/2014 12:48 PM, Stefan Hajnoczi wrote:
>> One more thing to add to the list:
>>
>> static void ivshmem_read(void *opaque, const uint8_t * buf, int flags)
>>
>> The "flags" argument should be "size".  Size should be checked before
>> accessing buf.
>
> You are welcome to send a fix and I will review it.

This is not what a maintainer should do.  A maintainer should, if 
possible, contribute fixes to improve the code.

I know this is very different from usual "company-style" development 
(even open source software can be developed on with methods more typical 
of proprietary software), but we're asking you to do it because you 
evidently understand ivshmem better than us.

Claudio has more experience with free/open-source software.  Since he's 
interested in ivshmem, he can help you too.  Perhaps you could try 
sending out the patch, and Claudio can review it and send pull requests 
at least in the beginning?

Paolo
