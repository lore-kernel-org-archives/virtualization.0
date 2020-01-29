From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Balloon pressuring page cache
Date: Tue, 28 Jan 2020 16:22:12 -0800
Message-ID: <CAJuQAmpDUyve2S+oxp9tLUhuRcnddXnNztC5PmYOOCpY6c68xg@mail.gmail.com>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1922392908477810118=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org, Wei Wang <wei.w.wang@intel.com>, David Rientjes <rientjes@google.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============1922392908477810118==
Content-Type: multipart/alternative; boundary="0000000000009b286c059d3c55f7"

--0000000000009b286c059d3c55f7
Content-Type: text/plain; charset="UTF-8"

A primary advantage of virtio balloon over other memory reclaim mechanisms
is that it can pressure the guest's page cache into shrinking.

However, since the balloon driver changed to using the shrinker API
<https://github.com/torvalds/linux/commit/71994620bb25a8b109388fefa9e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9>
this
use case has become a bit more tricky. I'm wondering what the intended
device implementation is.

When inflating the balloon against page cache (i.e. no free memory remains)
vmscan.c will both shrink page cache, but also invoke the shrinkers --
including the balloon's shrinker. So the balloon driver allocates memory
which requires reclaim, vmscan gets this memory by shrinking the balloon,
and then the driver adds the memory back to the balloon. Basically a busy
no-op.

If file IO is ongoing during this balloon inflation then the page cache
could be growing which further puts "back pressure" on the balloon trying
to inflate. In testing I've seen periods of > 45 seconds where balloon
inflation makes no net forward progress.

This wasn't a problem before the change to the shrinker API since forced
balloon deflation only occurred via the OOM notifier callback which was
invoked only after the page cache had depleted.

Is this new busy behavior working as intended?

--0000000000009b286c059d3c55f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">A primary advantage of virtio balloon over other=C2=A0memo=
ry reclaim mechanisms is that it can=C2=A0pressure the guest&#39;s page cac=
he into shrinking.<div><br></div><div>However, since the balloon driver <a =
href=3D"https://github.com/torvalds/linux/commit/71994620bb25a8b109388fefa9=
e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9" target=3D"_blank">cha=
nged to using the shrinker API</a>=C2=A0this use case has become a bit more=
 tricky. I&#39;m wondering what the intended device implementation is.</div=
><div><br></div><div>When inflating the balloon against page cache (i.e. no=
 free memory remains) vmscan.c will both shrink page cache, but also invoke=
 the shrinkers -- including the balloon&#39;s shrinker. So the balloon driv=
er allocates memory which requires reclaim, vmscan gets this memory by shri=
nking the balloon, and then the driver adds the memory back to the balloon.=
 Basically a busy no-op.</div><div><br></div><div>If file IO is ongoing dur=
ing this balloon inflation then the page cache could be growing which furth=
er puts &quot;back pressure&quot; on the balloon trying to inflate. In test=
ing I&#39;ve seen periods of &gt; 45 seconds where balloon inflation makes =
no net forward progress.</div><div><br></div><div>This wasn&#39;t a problem=
 before the change to the shrinker API since forced balloon deflation only =
occurred via the OOM notifier callback which was invoked only after the pag=
e cache had depleted.</div><div><br></div><div>Is this new busy behavior wo=
rking as intended?</div></div>

--0000000000009b286c059d3c55f7--

--===============1922392908477810118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1922392908477810118==--
