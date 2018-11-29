From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: Bug#912087: reassign to systemd #912087 | openssh-server: Slow
	startup after the upgrade to 7.9p1
Date: Thu, 29 Nov 2018 14:54:48 +0100
Message-ID: <20181129135446.jsrckfmy2urcsb5g__26827.2982015789$1543502267$gmane$org@breakpoint.cc>
References: <20181126230521.twugjqastskgmolx@breakpoint.cc>
	<154070458824.7875.5742628083142648872.reportbug@mitsos>
	<68d6a356-bb0c-d879-4de3-db7a632bc162@debian.org>
	<20181127130935.4vh3pipxupzr2n6m@breakpoint.cc>
	<CAA7U3HN8aV-BrYGS4XNgXsfAL8eFcxdjReM-5VZOSnJntVanJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAA7U3HN8aV-BrYGS4XNgXsfAL8eFcxdjReM-5VZOSnJntVanJw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Olaf van der Spek <olafvdspek@gmail.com>, Alok Kataria <akataria@vmware.com>, Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Biebl <biebl@debian.org>, 912087@bugs.debian.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2018-11-28 13:43:07 [+0100], Olaf van der Spek wrote:
> > > They might just as well install haveged or configure virtio-rng in such
> > > a case.
> >
> > Right. Do you think, that it would necessary to add something to the
> > release notes?
> 
> I do. ;)
> What's the workaround for VMware?
> 
> Does it just take longer to start or do some services not start at all?

It will take longer to start, it will start. Let me pass that workaround
question to someone from vmware/virtualbox and #912087:

On a recent kernel you see something like that:
[   68.823013] random: crng init done

which means it took almost 69 seconds for the system to initialize its
rng. OpenSSH 7.9 can be compilied against OpenSSL 1.1.1 which in turn
switched to getrandom() (for its randomness).
This syscall will block until kernel's rng is ready which took in this
example almost 69 seconds.
Those "high" numbers are not a problem on decent/recent HW but occur
oftern on in virtualized environments.
For KVM we have CONFIG_HW_RANDOM_VIRTIO. Are there any plans to get
something similar for VMware/Vbox?

[0] http://bugs.debian.org/912087

Sebastian
