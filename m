From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Sat, 21 Jun 2014 17:34:36 +0800
Message-ID: <CAJSP0QXpEDfqVAswv4_9CEtfwRrMYpVuRoh9T9+vi2v_wxGExQ@mail.gmail.com>
References: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
	<53A00464.8090609@6wind.com> <53A00DEB.8030400@redhat.com>
	<20140618104849.GH14030@stefanha-thinkpad.redhat.com>
	<53A1A8BE.3000801@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: David Marchand <david.marchand@6wind.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent JARDIN <vincent.jardin@6wind.com>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 18, 2014 at 10:57 PM, David Marchand
<david.marchand@6wind.com> wrote:
> On 06/18/2014 12:48 PM, Stefan Hajnoczi wrote:
>>
>> One more thing to add to the list:
>>
>> static void ivshmem_read(void *opaque, const uint8_t * buf, int flags)
>>
>> The "flags" argument should be "size".  Size should be checked before
>> accessing buf.
>
>
> You are welcome to send a fix and I will review it.

I don't plan to send ivshmem patches in the near future because I
don't use or support it.

I thought you were interested in bringing ivshmem up to a level where
distros feel comfortable enabling and supporting it.  Getting there
will require effort from you to audit, clean up, and achieve test
coverage.  That's what a maintainer needs to do in a case like this.

Stefan
