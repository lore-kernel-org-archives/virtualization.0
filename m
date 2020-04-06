From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost: disable for OABI
Date: Mon, 6 Apr 2020 09:02:02 -0400
Message-ID: <20200406085707-mutt-send-email-mst@kernel.org>
References: <20200406121233.109889-1-mst@redhat.com>
 <20200406121233.109889-3-mst@redhat.com>
 <CAK8P3a1nce31itwMKbmXoNZh-Y68m3GX_WwzNiaBuk280VFh-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1nce31itwMKbmXoNZh-Y68m3GX_WwzNiaBuk280VFh-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "christophe.lyon@st.com" <christophe.lyon@st.com>, kbuild test robot <lkp@intel.com>, "daniel.santos@pobox.com" <daniel.santos@pobox.com>, Jason Wang <jasowang@redhat.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, Russell King <rmk+kernel@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, virtualization@lists.linux-foundation
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 02:50:32PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 6, 2020 at 2:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> >
> > +config VHOST_DPN
> > +       bool "VHOST dependencies"
> > +       depends on !ARM || AEABI
> > +       default y
> > +       help
> > +         Anything selecting VHOST or VHOST_RING must depend on VHOST_DPN.
> > +         This excludes the deprecated ARM ABI since that forces a 4 byte
> > +         alignment on all structs - incompatible with virtio spec requirements.
> > +
> 
> This should not be a user-visible option, so just make this 'def_bool
> !ARM || AEABI'
> 
>       Arnd

I like keeping some kind of hint around for when one tries to understand
why is a specific symbol visible.

-- 
MST
