From: Steve Glass <stevie.glass@gmail.com>
Subject: vhost question
Date: Sun, 18 Mar 2012 22:43:41 +1000
Message-ID: <CADC0ay0v2+mzmkR_urPUe-rvGvdT-BbEmh6j7+wPfY0WsA4vbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7857700698230144815=="
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

--===============7857700698230144815==
Content-Type: multipart/alternative; boundary=f46d04428b8ea0691004bb83ca4b

--f46d04428b8ea0691004bb83ca4b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm using virtio to implement a mac80211 device in the guest. On the host
side I plan to use a simple network simulation to control delivery of
frames between guests. Right now I've used the vhost approach on the host
side and can pass buffers from guest to host and back using virtio.

My immediate problem is how to have the host-side tx kick handler get the
host-side rx kick handler to run in order to deliver a frame? In the tx
kick handler I copy the frame into a queue for the receiving guest. In the
rx_handler I take queued frames and copy them into the rx buffers and wake
the guest. The problem is that if no frames are ready for delivery when the
guest rx kick handler runs then it has to exit and somehow I have to
arrange that it runs again (in the receiver's process context) when there
are frames to deliver.

How can I get my host-side tx kick handler to wake the host-side rx kick
handler to deliver frames to the guest?

Steve

--

static void
handle_rx(struct vhost_work *work)
{
int n;
unsigned out, in;
struct transmission *t;
u16 frames = 0;
struct vhost_poll *p = container_of(work, struct vhost_poll, work);
struct vhost_virtqueue *vq = container_of(p, struct vhost_virtqueue, poll);
struct vhost_node *node = container_of(vq, struct vhost_node,
vqs[WLAN_VQ_RX]);
struct vhost_dev *dev = &node->vdev;

mutex_lock(&vq->mutex);
vhost_disable_notify(dev, vq);
while (!queue_empty(&node->rxq)) {
n = vhost_get_vq_desc(dev, vq, vq->iov, ARRAY_SIZE(vq->iov), &out, &in,
NULL, NULL);
if (0 < n || n == vq->num)
break;
if ((t = queue_pop(&node->rxq))) {
BUG_ON(copy_to_user(vq->iov[0].iov_base, t->buf, t->buf_sz));
vq->iov[0].iov_len = t->buf_sz;
// ToDo: copy_to_user the rx_status
vhost_add_used(vq, n, out);
transmission_free(t);
++frames;
}
}
if (frames)
vhost_signal(dev, vq);
vhost_enable_notify(dev, vq);
mutex_unlock(&vq->mutex);
}

static void
handle_tx(struct vhost_work *work)
{
int n;
unsigned out, in;
struct transmission *t;
struct vhost_poll *p = container_of(work, struct vhost_poll, work);
struct vhost_virtqueue *vq = container_of(p, struct vhost_virtqueue, poll);
struct vhost_node *w = container_of(vq, struct vhost_node, vqs[WLAN_VQ_TX]);
struct vhost_dev *dev = &w->vdev;

mutex_lock(&vq->mutex);
do {
vhost_disable_notify(dev, vq);
n = vhost_get_vq_desc(dev, vq, vq->iov, ARRAY_SIZE(vq->iov), &out, &in,
NULL, NULL);
while (n >= 0 && n != vq->num) {
struct vhost_node *receiver = net_get_receiver(w);
if(receiver) {
if((t = transmission_alloc())) {
BUG_ON(copy_from_user(t->buf, vq->iov[1].iov_base, vq->iov[1].iov_len));
t->buf_sz = vq->iov[1].iov_len;
queue_push(&receiver->rxq, t);
// ToDo: kick receiver's handle_rx
// ToDo: populate TX status
} else {
pr_warn("%s: out of memory - packet dropped!", __func__);
// ToDo: populate TX status
}
} else {
pr_debug("%s: no receivers in range!", __func__);
// ToDo: populate TX status
}
vhost_add_used(vq, n, out);
n = vhost_get_vq_desc(dev, vq, vq->iov, ARRAY_SIZE(vq->iov), &out, &in,
NULL, NULL);
}
vhost_signal(dev, vq);
} while (vhost_enable_notify(dev, vq));
mutex_unlock(&vq->mutex);
}

--f46d04428b8ea0691004bb83ca4b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style>Hi,</div><div style><br class=3D"Apple-interchange-newline">I&#3=
9;m using virtio to implement a mac80211 device in the guest. On the host s=
ide I plan to use a simple network simulation to control delivery of frames=
 between guests. Right now I&#39;ve used the vhost approach on the host sid=
e and can pass buffers from guest to host and back using virtio.</div>
<div style><br></div><div style>My immediate problem is how to have the hos=
t-side tx kick handler get the host-side rx kick handler to run in order to=
 deliver a frame?=A0In the tx kick handler I copy the frame into a queue fo=
r the receiving guest. In the rx_handler I take queued frames and copy them=
 into the rx buffers and wake the guest. The problem is that if no frames a=
re ready for delivery when the guest rx kick handler runs then it has to ex=
it and somehow I have to arrange that it runs again (in the receiver&#39;s =
process context) when there are frames to deliver.</div>
<div style><br></div><div style>How can I get my host-side tx kick handler =
to wake the host-side rx kick handler to deliver frames to the guest?</div>=
<div style><br></div><div style>Steve</div><div style><br></div><div style>
--</div><div style><div><br></div><div><font face=3D"&#39;courier new&#39;,=
 monospace">static void</font></div><div><font face=3D"&#39;courier new&#39=
;, monospace">handle_rx(struct vhost_work *work)</font></div><div><font fac=
e=3D"&#39;courier new&#39;, monospace">{</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>int n;</font></div><div><font face=3D"&#39;courier n=
ew&#39;, monospace"><span style=3D"white-space:pre-wrap">	</span>unsigned o=
ut, in;</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>struct transmission *t;</font></div><div><font face=
=3D"&#39;courier new&#39;, monospace"><span style=3D"white-space:pre-wrap">=
	</span>u16 frames =3D 0;</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>struct vhost_poll *p =3D container_of(work, struct v=
host_poll, work);</font></div><div><font face=3D"&#39;courier new&#39;, mon=
ospace"><span style=3D"white-space:pre-wrap">	</span>struct vhost_virtqueue=
 *vq =3D container_of(p, struct vhost_virtqueue, poll);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>struct vhost_node *node =3D container_of(vq, struct =
vhost_node, vqs[WLAN_VQ_RX]);</font></div><div><font face=3D"&#39;courier n=
ew&#39;, monospace"><span style=3D"white-space:pre-wrap">	</span>struct vho=
st_dev *dev =3D &amp;node-&gt;vdev;</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><br></font></div><div>=
<font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-space:=
pre-wrap">	</span>mutex_lock(&amp;vq-&gt;mutex);</font></div><div><span sty=
le=3D"font-family:&#39;courier new&#39;,monospace;white-space:pre-wrap">	</=
span><span style=3D"font-family:&#39;courier new&#39;,monospace">vhost_disa=
ble_notify(dev, vq);</span><br>
</div><div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"w=
hite-space:pre-wrap">	</span>while (!queue_empty(&amp;node-&gt;rxq)) {</fon=
t></div><div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D=
"white-space:pre-wrap">		</span>n =3D vhost_get_vq_desc(dev, vq, vq-&gt;iov=
, ARRAY_SIZE(vq-&gt;iov), &amp;out, &amp;in, NULL, NULL);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">		</span>if (0 &lt; n || n =3D=3D vq-&gt;num)</font></div><d=
iv><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-spa=
ce:pre-wrap">			</span>break;</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">		</span>if ((t =3D queue_pop(&amp;node-&gt;rxq))) {</font><=
/div><div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"wh=
ite-space:pre-wrap">			</span>BUG_ON(copy_to_user(vq-&gt;iov[0].iov_base, t=
-&gt;buf, t-&gt;buf_sz));</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">			</span>vq-&gt;iov[0].iov_len =3D t-&gt;buf_sz;</font></di=
v><div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white=
-space:pre-wrap">			</span>// ToDo: copy_to_user the rx_status</font></div>
<div><span style=3D"font-family:&#39;courier new&#39;,monospace;white-space=
:pre-wrap">			</span><span style=3D"font-family:&#39;courier new&#39;,monos=
pace">vhost_add_used(vq, n, out);</span><br></div><div><font face=3D"&#39;c=
ourier new&#39;, monospace"><span style=3D"white-space:pre-wrap">			</span>=
transmission_free(t);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">			</span>++frames;</font></div><div><font face=3D"&#39;cour=
ier new&#39;, monospace"><span style=3D"white-space:pre-wrap">		</span>}</f=
ont></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>}</font></div><div><font face=3D"&#39;courier new&#3=
9;, monospace"><span style=3D"white-space:pre-wrap">	</span>if (frames)</fo=
nt></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">		</span>vhost_signal(dev, vq);</font></div><div><font face=
=3D"&#39;courier new&#39;, monospace"><span style=3D"white-space:pre-wrap">=
	</span>vhost_enable_notify(dev, vq);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>mutex_unlock(&amp;vq-&gt;mutex);</font></div><div><f=
ont face=3D"&#39;courier new&#39;, monospace">}</font></div><div><font face=
=3D"&#39;courier new&#39;, monospace"><br>
</font></div><div><font face=3D"&#39;courier new&#39;, monospace">static vo=
id</font></div><div><font face=3D"&#39;courier new&#39;, monospace">handle_=
tx(struct vhost_work *work)</font></div><div><font face=3D"&#39;courier new=
&#39;, monospace">{</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>int n;</font></div><div><font face=3D"&#39;courier n=
ew&#39;, monospace"><span style=3D"white-space:pre-wrap">	</span>unsigned o=
ut, in;</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>struct transmission *t;</font></div><div><font face=
=3D"&#39;courier new&#39;, monospace"><span style=3D"white-space:pre-wrap">=
	</span>struct vhost_poll *p =3D container_of(work, struct vhost_poll, work=
);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>struct vhost_virtqueue *vq =3D container_of(p, struc=
t vhost_virtqueue, poll);</font></div><div><font face=3D"&#39;courier new&#=
39;, monospace"><span style=3D"white-space:pre-wrap">	</span>struct vhost_n=
ode *w =3D container_of(vq, struct vhost_node, vqs[WLAN_VQ_TX]);</font></di=
v>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>struct vhost_dev *dev =3D &amp;w-&gt;vdev;</font></d=
iv><div><font face=3D"&#39;courier new&#39;, monospace"><br></font></div><d=
iv><span style=3D"font-family:&#39;courier new&#39;,monospace;white-space:p=
re-wrap">	</span><span style=3D"font-family:&#39;courier new&#39;,monospace=
">mutex_lock(&amp;vq-&gt;mutex);</span><br>
</div><div><span style=3D"font-family:&#39;courier new&#39;,monospace;white=
-space:pre-wrap">	</span><span style=3D"font-family:&#39;courier new&#39;,m=
onospace">do {</span><br></div><div><font face=3D"&#39;courier new&#39;, mo=
nospace"><span style=3D"white-space:pre-wrap">		</span>vhost_disable_notify=
(dev, vq);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">		</span>n =3D vhost_get_vq_desc(dev, vq, vq-&gt;iov, ARRAY_=
SIZE(vq-&gt;iov), &amp;out, &amp;in, NULL, NULL);</font></div><div><font fa=
ce=3D"&#39;courier new&#39;, monospace"><span style=3D"white-space:pre-wrap=
">		</span>while (n &gt;=3D 0 &amp;&amp; n !=3D vq-&gt;num) {</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">			</span>struct vhost_node *receiver =3D net_get_receiver(w=
);</font></div><div><font face=3D"&#39;courier new&#39;, monospace"><span s=
tyle=3D"white-space:pre-wrap">			</span>if(receiver) {</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">				</span>if((t =3D transmission_alloc())) {</font></div><d=
iv><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-spa=
ce:pre-wrap">					</span>BUG_ON(copy_from_user(t-&gt;buf, vq-&gt;iov[1].iov=
_base, vq-&gt;iov[1].iov_len));</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">					</span>t-&gt;buf_sz =3D vq-&gt;iov[1].iov_len;</font></=
div><div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"whi=
te-space:pre-wrap">					</span>queue_push(&amp;receiver-&gt;rxq, t);</font>=
</div>
<div><span style=3D"font-family:&#39;courier new&#39;,monospace;white-space=
:pre-wrap">					</span><font face=3D"&#39;courier new&#39;, monospace">// T=
oDo: kick receiver&#39;s handle_rx</font></div><div><font face=3D"&#39;cour=
ier new&#39;, monospace"><span style=3D"white-space:pre-wrap">					</span>/=
/ ToDo: populate TX status</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">				</span>} else {</font></div><div><font face=3D"&#39;cour=
ier new&#39;, monospace"><span style=3D"white-space:pre-wrap">					</span>p=
r_warn(&quot;%s: out of memory - packet dropped!&quot;, __func__);</font></=
div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">					</span>// ToDo: populate TX status</font></div><div><fo=
nt face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-space:pre=
-wrap">				</span>}</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">			</span>} else {</font></div><div><font face=3D"&#39;couri=
er new&#39;, monospace"><span style=3D"white-space:pre-wrap">				</span>pr_=
debug(&quot;%s: no receivers in range!&quot;, __func__);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">				</span>// ToDo: populate TX status</font></div><div><fon=
t face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-space:pre-=
wrap">			</span>}</font></div>
<div><span style=3D"font-family:&#39;courier new&#39;,monospace;white-space=
:pre-wrap">			</span><span style=3D"font-family:&#39;courier new&#39;,monos=
pace">vhost_add_used(vq, n, out);</span><br></div><div><font face=3D"&#39;c=
ourier new&#39;, monospace"><span style=3D"white-space:pre-wrap">			</span>=
n =3D vhost_get_vq_desc(dev, vq, vq-&gt;iov, ARRAY_SIZE(vq-&gt;iov), &amp;o=
ut, &amp;in, NULL, NULL);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">		</span>}</font></div><div><font face=3D"&#39;courier new&#=
39;, monospace"><span style=3D"white-space:pre-wrap">		</span>vhost_signal(=
dev, vq);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>} while (vhost_enable_notify(dev, vq));</font></div>=
<div><font face=3D"&#39;courier new&#39;, monospace"><span style=3D"white-s=
pace:pre-wrap">	</span>mutex_unlock(&amp;vq-&gt;mutex);</font></div>
<div><font face=3D"&#39;courier new&#39;, monospace">}</font></div></div>

--f46d04428b8ea0691004bb83ca4b--

--===============7857700698230144815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7857700698230144815==--
