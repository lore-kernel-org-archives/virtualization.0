From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/paravirt: Cleanup native_patch()
Date: Mon, 10 Sep 2018 09:01:08 +0200
Message-ID: <20180910070108.GA21406__12583.446983672$1536562756$gmane$org@zn.tnic>
References: <20180907104917.12502-1-bp@alien8.de>
	<20180907105112.GD12849@zn.tnic> <20180907201050.GF12849@zn.tnic>
	<65bb69fa-855f-9efc-19ba-c0fab69f468c@suse.com>
	<20180908152800.GA8286@zn.tnic>
	<229941d4-c152-89fb-eb75-fcfa5f265ad4@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <229941d4-c152-89fb-eb75-fcfa5f265ad4@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 10, 2018 at 08:54:12AM +0200, Juergen Gross wrote:
> > +	case PARAVIRT_PATCH(lock.queued_spin_unlock):
> > +		if (pv_is_native_spin_unlock())
> > +			return paravirt_patch_insns(ibuf, len,
> > +						    start_lock_queued_spin_unlock,
> > +						    end_lock_queued_spin_unlock);
> > +		else
> > +			return paravirt_patch_default(type, ibuf, addr, len);
> 
> Why not replace the else clause by a "break;" and ...

Because I think that exiting right then and there is much easier to
follow than adding all those breaks and wading through ifdeffery
to realize that this is the default path and we'll end up calling
paravirt_patch_default() in the end.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
