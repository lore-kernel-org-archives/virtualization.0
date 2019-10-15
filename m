From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: question: asynchronous notification from vhost
Date: Tue, 15 Oct 2019 11:23:13 +0200
Message-ID: <20191015092313.GA31275@ubuntu>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I'm developing a virtualised audio / DSP virtio and vhost driver pair 
and I'm currently somewhat stuck trying to figure out how to 
asynchronously notify the guest from the vhost driver. I'm using the 
vhost_add_used_and_signal() function to return data back to the guest 
in the guest context, when the guest initiated an operation, that's 
working well. But how do I "kick" the guest from an asynchronous, e.g. 
from an interrupt thread context?

Thanks
Guennadi
