From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 14:35:20 +0100
Message-ID: <CAFEAcA_R-N-M9ZS68OWK2LiPGK2bD6uJz=+fMoQWzE+17MekZQ__23630.7882391431$1369834559$gmane$org@mail.gmail.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<20130529132430.GA9363@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529132430.GA9363@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On 29 May 2013 14:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, May 29, 2013 at 07:52:37AM -0500, Anthony Liguori wrote:
>> 1) C makes no guarantees about structure layout beyond the first
>>    member.  Yes, if it's naturally aligned or has a packed attribute,
>>    GCC does the right thing.  But this isn't kernel land anymore,
>>    portability matters and there are more compilers than GCC.
>
> You expect a compiler to pad this structure:
>
> struct foo {
>         uint8_t a;
>         uint8_t b;
>         uint16_t c;
>         uint32_t d;
> };
>
> I'm guessing any compiler that decides to waste memory in this way
> will quickly get dropped by users and then we won't worry
> about building QEMU with it.

Structure alignment is a platform ABI choice. Oddly enough people
choose operating systems on more criteria than the amount of
padding their ABI mandates in structures.

In any case it's really tedious to read a structure and wade
through working out whether it's going to have all its members
naturally aligned, especially once it's more than a handful
of members in size. And getting it wrong is "silent portability
problem".

thanks
-- PMM
