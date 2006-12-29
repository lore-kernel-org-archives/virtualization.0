From: bert hubert <bert.hubert@netherlabs.nl>
Subject: Re: lhype on 2.6.20-rc2: Guest didn't handle trap 6 at c071b594
	(cr2=00000000, err=0)
Date: Fri, 29 Dec 2006 12:05:30 +0100
Message-ID: <20061229110530.GA18976@outpost.ds9a.nl>
References: <20061227132520.GA32685@outpost.ds9a.nl>
	<1167272613.30506.5.camel@localhost.localdomain>
	<20061228114542.GB18047@outpost.ds9a.nl>
	<1167348883.30506.47.camel@localhost.localdomain>
	<20061229095412.GA16260@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061229095412.GA16260@outpost.ds9a.nl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 29, 2006 at 10:54:12AM +0100, bert hubert wrote:
> We're getting further, but no cigar yet!
> I now get this:

> [    0.820000] EIP is at mwait_idle_with_hints+0x1e/0x3a

idle=3Dhalt did the trick!

[    0.290000] Booting paravirtualized kernel on lhype

Now to get me a decent root image.. but things are looking good!

Some errors about 'IRQ handler type mismatches', and the rtc appears to be
off: [ 10.070000] rtc-test rtc-test.0: setting the system clock to
1970-01-05 22:03:49 (425029)

Thanks Rusty! If there is anything specific that needs testing, let me know.

	Bert

-- =

http://www.PowerDNS.com      Open source, database driven DNS Software =

http://netherlabs.nl              Open and Closed source services
