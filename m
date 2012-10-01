From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 3/3] virtio_console: Don't initialize buffers to zero
Date: Mon, 1 Oct 2012 13:54:17 +0530
Message-ID: <20121001082417.GC9810@amit.redhat.com>
References: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
	<1348580837-10919-4-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1348580837-10919-4-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com
Cc: sjurbren@stericsson.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 25 Sep 2012 [15:47:17], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> =

> Skip initializing the receive buffers.

This tells 'what', but not 'why'.  Please add some more description.
For the generic virtio ports case, at least, my original thinking was
to not send random guest data to the host device.  However, we don't
have any device isolation in the host yet, and doing that will be
expensive, so it's not going to be done in the near future.. this can
be safely skipped.

Also, please make this patch 1/3, so we don't end up doing

 kzalloc->kmalloc+memset->kmalloc

Thanks,
		Amit
