From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: virtio_blk: Less function calls in init_vq() after error detection
Date: Tue, 13 Sep 2016 20:24:58 +0200
Message-ID: <44fd46f6-441a-d497-9157-7e2a0f3f45da@de.ibm.com>
References: <566ABCD9.1060404@users.sourceforge.net>
	<02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
	<f56845a8-03c6-d3f7-6091-99dba9835780@users.sourceforge.net>
	<e918e655-cd86-c3c8-d911-9dfc03b03e19@de.ibm.com>
	<7da823eb-939c-9ee6-32bf-db296e6a96f6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7da823eb-939c-9ee6-32bf-db296e6a96f6@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Minfei Huang <minfei.hmf@alibaba-inc.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 09/13/2016 07:30 PM, SF Markus Elfring wrote:
[...]
> Unfortunately, I get an other impression here after a closer look.
> =

> Can it be that the discussed commit from 2016-08-09 accepted (or tolerate=
d)
> two weaknesses at least?
> =

> 1. Commit title:
>    Is the word "slient" a typo?
>    Would you like to read "silent" there instead?
> =

> 2. Source code:
>    Why would another memory allocation be attempted if it could be determ=
ined quicker
>    that a previous one failed and this function implementation can not su=
cceed then?
> =

>    How much will it matter in general that two function calls are perform=
ed
>    in this use case without checking their return values immediately?
>    https://cwe.mitre.org/data/definitions/252.html
> =

> 	if (!names || !callbacks || !vqs) { =85
> =

>    https://cwe.mitre.org/data/definitions/754.html
> =


The return values are checked, just a bit later.
Markus, kernel patches are not about be formally correct vs. CodingStyle an=
d/or checkpatch
or against code guidelines from sombody else. You will find many people con=
sider gotos
an no-go, still it is accepted in the kernel for good reasons.
You have to think about each change and its tradeoffs (e.g simplicity vs. p=
erformance) =

for each code part again. Here we have slow path error handling, so given t=
he low coverage
of these code parts, simplicity is important.
Yes, your code makes an unlikely error case bail out faster, but is the cos=
t of your
patch (review time, danger of adding bugs, danger of merge conflicts, makin=
g git blame less
useful) in sync with the expected win? This is certainly Michaels area of m=
aintainership =

and if he wants your patch, it will be fine too. (Well, having a label betw=
een the if and =

the function like
>   	if (err)
> + free_vblk_vqs:
>  		kfree(vblk->vqs);

is certainly ugly in itself)


> Was the software development attention a bit too low as it happens occasi=
onally?
> =

> =

> I hope that my suggestions can improve the affected situation a bit more
> also for this software module.

Do you realize that your discussion style is not very helpful?
I just grepped the last LKML mails and you already pissed of several mainta=
iners
in totally different areas. When that happens, why don't you stop for a mom=
ent and
think about "what is going wrong right now". =


Your attitude seems to be "I spend my spare time doing this, please thank m=
e for that".
The thing is, with each patch you actually request time from the maintainer.
Now here begins the interesting part: Is the patch just a cosmetic change t=
hat does
not give you any benefit or is the patch improving the code. And remember: =
there
are always tradeoffs: performance, code size, code maintainability etc.

See, some of your patches are accepted, e.g. the memdup_user changes have u=
sually
been applied by most maintainers including myself. If maintainers won't tak=
e other change,
please accept that. If you continue to waste peoples time by discussing "ma=
ybe" patches
you actually risk that people will stop taking any patches from you includi=
ng the "yes"
ones.

Christian
