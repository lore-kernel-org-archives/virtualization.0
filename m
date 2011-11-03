From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 4 of 5] virtio: avoid modulus operation
Date: Thu, 3 Nov 2011 09:51:15 +0200
Message-ID: <CAOJsxLEt6_y7jw0bRsaita4gfb2k+BAQMeRLs9PcHntGVSFvaQ__14729.2260583074$1321323105$gmane$org@mail.gmail.com>
References: <patchbomb.1320306168@localhost6.localdomain6>
	<05de9ee25e222c5206f3.1320306172@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <05de9ee25e222c5206f3.1320306172@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: MichaelS.Tsirkist@redhat.com, Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 3, 2011 at 9:42 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Since we know vq->vring.num is a power of 2, modulus is lazy (it's assert=
ed
> in vring_new_virtqueue()).
>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
> =A0drivers/virtio/virtio_ring.c | =A0 10 ++++++----
> =A01 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
> --- a/arch/x86/lguest/boot.c
> +++ b/arch/x86/lguest/boot.c
> @@ -1420,7 +1420,7 @@ __init void lguest_init(void)
> =A0 =A0 =A0 =A0add_preferred_console("hvc", 0, NULL);
>
> =A0 =A0 =A0 =A0/* Register our very early console. */
> - =A0 =A0 =A0 virtio_cons_early_init(early_put_chars);
> +// =A0 =A0 virtio_cons_early_init(early_put_chars);

What's this hunk here?
