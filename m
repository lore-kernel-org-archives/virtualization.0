From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] qemu: use virtio linux headers in
	portable code
Date: Wed, 29 May 2013 09:44:36 +0930
Message-ID: <87ip22od5f.fsf@rustcorp.com.au>
References: <CAFEAcA9HW6=F7QKpuof02hGTaAnLsZmoZ_-Yo98wKzeELi_zvA@mail.gmail.com>
	<20130526181017.GB3115@redhat.com> <51A253C6.7060303@redhat.com>
	<20130526183747.GB3427@redhat.com> <51A25A2D.8030700@redhat.com>
	<20130526200251.GA4305@redhat.com>
	<51A26E95.5000207@redhat.com> <878v314gb2.fsf@codemonkey.ws>
	<20130526214213.GB4828@redhat.com> <87txlp1bsy.fsf@codemonkey.ws>
	<20130527150217.GA16852@redhat.com> <87bo7wflhk.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bo7wflhk.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <anthony@codemonkey.ws> writes:
> The headers say they are BSD licensed... but they include a GPLv2+
> header.  Doesn't make a lot of sense, does it?

It makes perfect sense: you're overthinking it.  It just means that
copying the BSD headers outside Linux is encouraged.

And it's clearly nonsensical to claim the GPL on kernel headers means
that userspace needs to be GPL.  So please ignore this licensing
red-herring.

And we'll bikeshed the headers in the standard when we have to :)  They
certainly don't need to be cut&paste into the kernel sources.

Cheers,
Rusty.
