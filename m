From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Date: Fri, 22 Feb 2019 18:05:01 -0500
Message-ID: <20190222180341-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
	<20190222102610.GB5613@linux.intel.com>
	<20190222101728-mutt-send-email-mst@kernel.org>
	<20190222193156.GA6475@linux.intel.com>
	<20190222193305.GB6475@linux.intel.com>
	<20190222161636-mutt-send-email-mst@kernel.org>
	<20190222215001.GA21427@linux.intel.com>
	<f16bd565-0a7e-d7bb-a5e8-eda48ac8de80@gmail.com>
	<20190222223634.GA27601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190222223634.GA27601@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dgreid@chromium.org, virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, apronin@chromium.org, David Tolnay <dtolnay@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Feb 23, 2019 at 12:36:34AM +0200, Jarkko Sakkinen wrote:
> I do not require spec quality documentation. Just a few paragraphs of
> what is in crosvm, kernel etc. and something about inner workings to
> get a rough idea. No need for TCG level spec for this :-)

OTOH for virtio if there's no implementation in a popular
hypervisor/language, we do ask for a somewhat detailed
spec.

-- 
MST
