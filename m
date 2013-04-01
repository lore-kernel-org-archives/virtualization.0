From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/8] virtio: do not export "u16" and "u64" to userspace
Date: Tue, 02 Apr 2013 09:59:54 +1030
Message-ID: <87y5d16d8t.fsf@rustcorp.com.au>
References: <1364839156.21627.65.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364839156.21627.65.camel@x61.thuisdomein>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Bolle <pebolle@tiscali.nl>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paul Bolle <pebolle@tiscali.nl> writes:
> virtio_balloon.h exports "u16" and "u64" to userspace. Use "__u16" and
> "__u64" instead.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Tested with a kernel build.
>
> 1) Both types are used in this header for quite some time now. So is my
> patch flawed or doesn't userspace actually use virtio_balloon.h?

qemu rolls its own copy, but this is still a valid fix.

Thanks,
Rusty.
