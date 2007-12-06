From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/19] unify desc_struct
Date: Thu, 06 Dec 2007 14:03:21 -0800
Message-ID: <475871A9.5050707__6816.05632785267$1196978877$gmane$org@goop.org>
References: <1196957800568-git-send-email-gcosta@redhat.com>	
	<11969578092869-git-send-email-gcosta@redhat.com>	
	<200712062154.40075.ak@suse.de>
	<5d6222a80712061320w1224fa10r1d15f214c7e45862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80712061320w1224fa10r1d15f214c7e45862@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> On Dec 6, 2007 6:54 PM, Andi Kleen <ak@suse.de> wrote:
>   
>>> +/*
>>> + * FIXME: Acessing the desc_struct through its fields is more elegant,
>>> + * and should be the one valid thing to do. However, a lot of open code
>>> + * still touches the a and b acessors, and doing this allow us to do it
>>> + * incrementally. We keep the signature as a struct, rather than an union,
>>> + * so we can get rid of it transparently in the future -- glommer
>>> + */
>>> +#define raw_desc_struct struct { unsigned int a, b; }
>>> +#define detailed_desc_struct                                   \
>>> +  struct {                                                       \
>>> +     u16 limit0;                                             \
>>> +     u16 base0;                                              \
>>> +     unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;    \
>>> +     unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 :8;\
>>> +  }
>>>       
>> The standard clean way to do this is with a anonymous union.
>>     
> It is an anonymous union.
>
> However:
>
> * It's an union of structs
> * I wished to keep the toplevel type as a struct
> The alternative would be to write:
>
> struct desc_struct {
> union {
>     struct { unsigned int a, b; };
>     struct {
>                u16 limit0;
>                u16 base0;
>                unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;
>                unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 :8;
>     };
> };
> };
>
> Which is fine, it's all the same in the end. Just with more shift
> rights, and more visual pollution.
>   

No, that's much clearer.  It's a pity that the anonymous struct/union
syntax isn't general enough to allow:

struct desc_packed {
               u16 limit0;
               u16 base0;
               unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;
               unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 :8;
};

struct desc {
	struct desc_packed;
};

    J
