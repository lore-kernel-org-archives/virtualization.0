From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio-blk spec: document topology info
Date: Wed, 04 Jul 2012 15:22:36 +0930
Message-ID: <87d34cvzrv.fsf@rustcorp.com.au>
References: <1341321412-24214-1-git-send-email-pbonzini@redhat.com> <1341321412-24214-2-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1341321412-24214-2-git-send-email-pbonzini@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.osdl.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue,  3 Jul 2012 15:16:51 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Current QEMU and Linux drivers can export queue parameters via the
> virtio-blk configuration space.  Document this, since the next patch
> will have to add another configuration field after these.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Applied, thanks for the grammar fix, too!

> +        u8 physical_block_exp;
> +        u8 alignment_offset;
> +        u16 min_io_size;
> +        u32 opt_io_size;

These aren't entirely self-evident though :(

I've put the latest on github (your changes included!), so please patch
against that:

https://github.com/rustyrussell/virtio-spec

Thanks,
Rusty.
