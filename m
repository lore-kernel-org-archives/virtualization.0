From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Tue, 26 Mar 2013 17:22:22 -0700
Message-ID: <79aede60-5692-4d27-9cfa-7b5fbf96b987@email.android.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com>
	<8738vjer43.fsf@rustcorp.com.au>
	<20130326193911.GA19251@redhat.com>
	<87ip4d4sef.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ip4d4sef.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I would say let it be undefined... in most cases the host will know what device(s) will matter; e.g. if the guest is ppc no point in providing an I/O BAR.

Rusty Russell <rusty@rustcorp.com.au> wrote:

>"Michael S. Tsirkin" <mst@redhat.com> writes:
>> On Mon, Mar 25, 2013 at 08:30:28PM +1030, Rusty Russell wrote:
>>> Let's go back a level.  Do we still need I/O bars at all now?  Or
>can we
>>> say "if you want hundreds of vqs, use mem bars"?
>>> 
>>> hpa wanted the option to have either, but do we still want that?
>>
>> hpa says having both is required for BIOS, not just for speed with
>KVM.
>
>OK so the offset must not be applied to the I/O bar as you suggested.
>
>Since AFAICT I/O bars are deprecated, should we insist that there be a
>memory bar, and the I/O bar is optional?  Or just leave it entirely
>undefined, and say there can be either or both?
>
>I dislike the idea of BIOS code which assumed an I/O bar and thus won't
>work with a compliant device which doesn't provide one.  I'd prefer all
>compliant drivers to work with all compliant devices.
>
>Cheers,
>Rusty.

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
