From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 1/19] unify desc_struct
Date: Thu, 6 Dec 2007 19:20:43 -0200
Message-ID: <5d6222a80712061320w1224fa10r1d15f214c7e45862__16696.5434480973$1196976274$gmane$org@mail.gmail.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11969578092869-git-send-email-gcosta@redhat.com>
	<200712062154.40075.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712062154.40075.ak@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Dec 6, 2007 6:54 PM, Andi Kleen <ak@suse.de> wrote:
>
> > +/*
> > + * FIXME: Acessing the desc_struct through its fields is more elegant,
> > + * and should be the one valid thing to do. However, a lot of open code
> > + * still touches the a and b acessors, and doing this allow us to do it
> > + * incrementally. We keep the signature as a struct, rather than an union,
> > + * so we can get rid of it transparently in the future -- glommer
> > + */
> > +#define raw_desc_struct struct { unsigned int a, b; }
> > +#define detailed_desc_struct                                   \
> > +  struct {                                                       \
> > +     u16 limit0;                                             \
> > +     u16 base0;                                              \
> > +     unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;    \
> > +     unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 :8;\
> > +  }
>
> The standard clean way to do this is with a anonymous union.
It is an anonymous union.

However:

* It's an union of structs
* I wished to keep the toplevel type as a struct
The alternative would be to write:

struct desc_struct {
union {
    struct { unsigned int a, b; };
    struct {
               u16 limit0;
               u16 base0;
               unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;
               unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 :8;
    };
};
};

Which is fine, it's all the same in the end. Just with more shift
rights, and more visual pollution.


-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
