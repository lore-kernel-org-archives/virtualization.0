From: Arnau Verdaguer <averdaguer@clevernet.io>
Subject: virtio BPF offers incorrect packet length
Date: Wed, 24 Jul 2019 18:44:43 +0200
Message-ID: <CAFzp4AkgShgHFniuB5aQzLw_5uGLOFuRshSbbOipoA3-Arneqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000006e5415058e700721"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--0000000000006e5415058e700721
Content-Type: multipart/alternative; boundary="0000000000006e5411058e70071f"

--0000000000006e5411058e70071f
Content-Type: text/plain; charset="UTF-8"

Hi,

I suspect that the virtio network driver calls some skb BPF programs with
skb->data_end - skb->data != skb->len, but only for forwarded packets.

For instance, the attached sched_cls tc program prints skb->data,
skb->data_end and skb->len for each packet:

          <idle>-0     [000] ..s.   491.561727: 0: data: 3110080576
data_end: 3110080704 len: 262
          <idle>-0     [000] .Ns.   491.561752: 0: data: 3110080064
data_end: 3110080192 len: 250

As it can be seen, the frame length should be 262 and 250 bytes, but
data_end - data is always 128. For packets smaller than 128 it works fine.

I've tried the latest kernel (5.3-rc1) besides 4.14, 4.19, 5.2, etc., and
the error persists. Other drivers than virtio work as expected and I can
inspect every byte of the packet. Locally generated traffic also works as
expected.

To carry out this experiment I've used a Debian 10 virtual machine with
net.ipv4.ip_forward=1 and net.ipv4.conf.eth0.forwarding=1, forwarding
packets between its two virtio interfaces. The example program is run with
the following command, having BCC installed:

$> sudo python3 pkt_len_text.py eth0

Where "eth0" could be another ingress interface. The output is showed at
/sys/kernel/debug/tracing/trace_pipe.

Can anyone confirm if this error is reproducible, and does it have any
solutions?

BR.

Arnau

--0000000000006e5411058e70071f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I suspect that the virtio network driver calls =
some skb BPF programs with skb-&gt;data_end - skb-&gt;data !=3D skb-&gt;len=
, but only for forwarded packets.<br><br>For instance, the attached sched_c=
ls tc program prints skb-&gt;data, skb-&gt;data_end and skb-&gt;len for eac=
h packet:<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;idle&gt;-0 =C2=A0 =
=C2=A0 [000] ..s. =C2=A0 491.561727: 0: data: 3110080576 data_end: 31100807=
04 len: 262<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;idle&gt;-0 =C2=A0 =C2=
=A0 [000] .Ns. =C2=A0 491.561752: 0: data: 3110080064 data_end: 3110080192 =
len: 250<br><br>As it can be seen, the frame length should be 262 and 250 b=
ytes, but data_end - data is always 128. For packets smaller than 128 it wo=
rks fine.<br><br>I&#39;ve tried the latest kernel (5.3-rc1) besides 4.14, 4=
.19, 5.2, etc., and the error persists. Other drivers than virtio work as e=
xpected and I can inspect every byte of the packet. Locally generated traff=
ic also works as expected.<br><br>To carry out this experiment I&#39;ve use=
d a Debian 10 virtual machine with net.ipv4.ip_forward=3D1 and net.ipv4.con=
f.eth0.forwarding=3D1, forwarding packets between its two virtio interfaces=
. The example program is run with the following command, having BCC install=
ed:<br><br>$&gt; sudo python3 pkt_len_text.py eth0<br><br>Where &quot;eth0&=
quot; could be another ingress interface. The output is showed at /sys/kern=
el/debug/tracing/trace_pipe.<br><br>Can anyone confirm if this error is rep=
roducible, and does it have any solutions?<br><br>BR.<br><br>Arnau</div>

--0000000000006e5411058e70071f--

--0000000000006e5415058e700721
Content-Type: text/x-python; charset="US-ASCII"; name="pkt_len_test.py"
Content-Disposition: attachment; filename="pkt_len_test.py"
Content-Transfer-Encoding: base64
Content-ID: <f_jyhf7x7r0>
X-Attachment-Id: f_jyhf7x7r0

IyEvdXNyL2Jpbi9weXRob24KIyBDb3B5cmlnaHQgKGMpIFBMVU1ncmlkLCBJbmMuCiMgTGljZW5z
ZWQgdW5kZXIgdGhlIEFwYWNoZSBMaWNlbnNlLCBWZXJzaW9uIDIuMCAodGhlICJMaWNlbnNlIikK
aW1wb3J0IHN5cwpmcm9tIGJjYyBpbXBvcnQgQlBGCmZyb20gcHlyb3V0ZTIgaW1wb3J0IElQUm91
dGUKCmlwciA9IElQUm91dGUoKQoKdGV4dCA9ICIiIgogICAgaW50IHBrdF9sZW5fdGVzdChzdHJ1
Y3QgX19za19idWZmICpza2IpIHsKICAgIHZvaWQgKmRhdGFfZW5kID0gKHZvaWQgKikgKGxvbmcp
c2tiLT5kYXRhX2VuZDsKICAgIHZvaWQgKmRhdGEgPSAodm9pZCAqKSAobG9uZylza2ItPmRhdGE7
CiAgICBicGZfdHJhY2VfcHJpbnRrKCJkYXRhOiAldSBlbmQ6ICV1IGxlbjogJWQgXFxuIiwgZGF0
YSwgZGF0YV9lbmQsIHNrYi0+bGVuKTsKICAgIHJldHVybiAxOwp9CiIiIgoKdHJ5OgogICAgYiA9
IEJQRih0ZXh0PXRleHQsIGRlYnVnPTApCiAgICBmbiA9IGIubG9hZF9mdW5jKCJwa3RfbGVuX3Rl
c3QiLCBCUEYuU0NIRURfQ0xTKQogICAgaWR4ID0gaXByLmxpbmtfbG9va3VwKGlmbmFtZT1zdHIo
c3lzLmFyZ3ZbMV0pKVswXQoKICAgIGlwci50YygiYWRkIiwgImluZ3Jlc3MiLCBpZHgsICJmZmZm
OiIpCiAgICBpcHIudGMoImFkZC1maWx0ZXIiLCAiYnBmIiwgaWR4LCAiOjEiLCBmZD1mbi5mZCwK
ICAgICAgICAgICBuYW1lPWZuLm5hbWUsIHBhcmVudD0iZmZmZjoiLCBhY3Rpb249Im9rIiwgY2xh
c3NpZD0xKQogICAgaXByLnRjKCJhZGQiLCAic2ZxIiwgaWR4LCAiMToiKQogICAgaXByLnRjKCJh
ZGQtZmlsdGVyIiwgImJwZiIsIGlkeCwgIjoxIiwgZmQ9Zm4uZmQsCiAgICAgICAgICAgbmFtZT1m
bi5uYW1lLCBwYXJlbnQ9IjE6IiwgYWN0aW9uPSJvayIsIGNsYXNzaWQ9MSkKICAgIGZvbyA9IGlu
cHV0KCJQcmVzcyBhbnkga2V5IHRvIHJlbW92ZSB0aGUgZmlsdGVycyBhbmQgc3RvcCB0aGUgcHJv
Z3JhbSIpCiAgICBpcHIudGMoImRlbCIsICJpbmdyZXNzIiwgaWR4LCAiZmZmZjoiKQogICAgaXBy
LnRjKCJkZWwiLCAic2ZxIiwgaWR4LCAiMToiKQogICAgcHJpbnQoIkZpbHRlcnMgZGVsZXRlZCIp
CmV4Y2VwdCBFeGNlcHRpb24gYXMgZToKICAgIHByaW50KCJFcnJvcjogJXMiLCBlKQoK
--0000000000006e5415058e700721
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--0000000000006e5415058e700721--
