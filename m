From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [Q] vhost: returning misconfigured buffers
Date: Thu, 14 May 2020 14:55:44 +0200
Message-ID: <20200514125543.GA12665@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Many vhost drivers follow a common process to obtain and verify 
received buffers:

head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov), &out, &in,...);
if (head < 0) {
	return ret;
}
if (head == vq->num) {
	/* no buffer */
	return 0; /* or -EAGAIN or whatever */
}
if (out != EXPECTED_OUT_BUFFERS || in != EXPECTED_IN_BUFFERS) {
	return -EINVAL;
}
/* all good, use buffers */
vhost_add_used(...);

Which seems to me to be leaking buffers in the last error case - 
if the buffer configuration was unexpected. Shouldn't drivers in 
such cases also use vhost_add_used() to return the buffer?

Thanks
Guennadi
