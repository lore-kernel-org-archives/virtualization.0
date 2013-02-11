From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Use virtio device index to generate port
	name
Date: Mon, 11 Feb 2013 21:25:41 +0530
Message-ID: <20130211155541.GC8319@amit.redhat.com>
References: <1358425397-4584-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358425397-4584-1-git-send-email-sjur.brandeland@stericsson.com>
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
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 17 Jan 2013 [13:23:17], sjur.brandeland@stericsson.com wrote:
> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> =

> Use virtio device index for creating unique device port names.
> Current index allocation in virtio is based on a monotonically
> increasing variable "index". A better handling of this is to
> use device index which is allocated by ida.
> =

> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>

Acked-by: Amit Shah <amit.shah@redhat.com>

Rusty, please pick this one up.

Thanks,

		Amit
