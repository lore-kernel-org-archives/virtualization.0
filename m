From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2/3] fbdev: Make deferred I/O work as advertized
Date: Tue, 26 Feb 2008 10:01:16 -0500
Message-ID: <45a44e480802260701o7c616e3bjd5f86f4143be791b@mail.gmail.com>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
	 <87k5kt6vd3.fsf@pike.pond.sub.org>
	 <45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
	 <871w6z6ajs.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <871w6z6ajs.fsf@pike.pond.sub.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Markus Armbruster <armbru@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 26, 2008 at 9:45 AM, Markus Armbruster <armbru@redhat.com> wrote:
>
>  What about pushing the fb_defio fixes independently of any new
>  fb_defio users?  If fb_defio was worth merging into Linus's tree, it
>  should be worth fixing there, whether new users are in shape already
>  or not.

I think that Andrew's message is saying that there may be a race
condition in the defio patch itself as opposed to the defio user
patch.

If there is no race condition or other problems, then I think it would
make sense to merge the defio patch independent of metronomefb or
other new patches that use defio.

Thanks,
jaya
