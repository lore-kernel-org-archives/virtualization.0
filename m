From: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 1/2] rngd: add udev rule to source from hwrng if
	virtio-rng present
Date: Mon, 11 Aug 2014 15:30:30 +0200
Message-ID: <20140811133030.GA27247__539.892601273273$1407776733$gmane$org@lst.de>
References: <cover.1407416628.git.amit.shah@redhat.com>
	<dd2ddb8458e5ab5cffceb7fac2e3f71e9e2197f3.1407416628.git.amit.shah@redhat.com>
	<53E3D3FF.70707@linux.intel.com> <20140808090715.GG14400@grmbl.mre>
	<53E54533.8030109@linux.intel.com>
	<20140811071527.GB4184@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140811071527.GB4184@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: jgarzik@bitpay.com, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 11, 2014 at 12:45:27PM +0530, Amit Shah wrote:
> 
> What's the suggested value for rng->quality, though, for virtio-rng
> that I can use to ensure the kthread starts?
> 
> Should I use the 700 (70%) as proposed in the original patchset?  I'm
> not exactly sure how that value will be used as well..

There is no such thing as a suggested value, every number is wrong
to some degree.  The quality is an estimation of how random your
source really is; it's a property of your hardware. If the device is
virtual you're in trouble ;-)

Either you have a way to query the underlying real hardware, or
you do your whitening and entropy estimation in the backend driver --
then you can claim 100%.

	Torsten
