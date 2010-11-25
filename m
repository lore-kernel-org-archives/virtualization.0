From: devi thapa <devi.thapa@gmail.com>
Subject: Re: transport between guest and host
Date: Thu, 25 Nov 2010 22:13:18 +0530
Message-ID: <AANLkTimgiSxZsjC+kaNST_Gw4Fw+tEp7+UZTyfb6-k+E@mail.gmail.com>
References: <AANLkTin7L0OY_Z-RxuSY1TqjfQSK6aCPYgSnTwX1h7ht@mail.gmail.com>
	<AANLkTi=47msiiexrmSX_xQHJsJ=oG5JhwDGWta29npm2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=47msiiexrmSX_xQHJsJ=oG5JhwDGWta29npm2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Stefan,

      I want to transport modules from host and insert in guest and
transport the result back to host.

 Regards,
 Devi.

On Thu, Nov 25, 2010 at 8:30 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Nov 25, 2010 at 11:37 AM, devi thapa <devi.thapa@gmail.com> wrote:
>> =A0 =A0 =A0 =A0 =A0I have 2 queries.
>> 1. =A0Is virtio-serial or virtio-console data transfer kernel level and
>> efficient than vhostnet networking.
>> 2. =A0Is 9p efficient for communicating between guests and a host
>> using a virtio based transport. =A0Is this also kernel level transport.
>
> The right choice depends on what you are trying to do. =A0What are you
> trying to do :)?
>
> Stefan
>
