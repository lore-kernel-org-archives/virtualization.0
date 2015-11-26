From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] remoteproc: fix memory leak of remoteproc ida cache
	layers
Date: Thu, 26 Nov 2015 11:38:06 +0200
Message-ID: <CAK=WgbaYdUU8o-iAqJAOuTd_cXzkcYQ0Nt14beuZ=PwtXGtV3A@mail.gmail.com>
References: <1442449758-14594-1-git-send-email-s-anna@ti.com>
	<1442449758-14594-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1442449758-14594-3-git-send-email-s-anna@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Suman Anna <s-anna@ti.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Suman,

On Thu, Sep 17, 2015 at 3:29 AM, Suman Anna <s-anna@ti.com> wrote:
> The remoteproc core uses a static ida named rproc_dev_index for
> assigning an automatic index number to a registered remoteproc.
> The ida core may allocate some internal idr cache layers and ida
> bitmap upon any ida allocation, and all these layers are truely
> freed only upon the ida destruction. The rproc_dev_index ida is
> not destroyed at present, leading to a memory leak when using the
> remoteproc core as a module and atleast one rproc device is
> registered and unregistered.
>
> Fix this by invoking ida_destroy() in the remoteproc core module
> exit.

I saw there was some discussion about this between Michael, James and
Tejun whether this should be fixed in the IDA core or not.

Has it been resolved?

Thanks,
Ohad.
