From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] vhost: access check thinko fixes
Date: Mon, 4 Jan 2010 12:52:56 +1030
Message-ID: <201001041252.57997.rusty@rustcorp.com.au>
References: <20091224060058.GA26101@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20091224060058.GA26101@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 24 Dec 2009 04:30:58 pm Michael S. Tsirkin wrote:
> This fixes two issues with recent access checking patch:
> 1.  if (&d->vqs[i].private_data) -> if (d->vqs[i].private_data)
> 2.  we can't forbid log base changes while ring is running,
>     because host needs to resize log in rare cases
>     (e.g. when memory is added with a baloon)
>     and in that case it needs to increase log size with realloc,
>     which might move the log address.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, applied.

Rusty.

