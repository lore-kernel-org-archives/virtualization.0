From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: virtio-gpu: Hang on shutdown after suspend/resume with virtio
Date: Tue, 13 Mar 2018 15:27:01 +0100
Message-ID: <65249e88-0694-d479-1d77-55e1f1f50b6f__33530.3881242455$1520951118$gmane$org@de.ibm.com>
References: <92144051-e8ac-de5d-3fac-87dfd0e8270b@de.ibm.com>
	<01fcd61b-1883-1baa-b0c5-c79b4942ed35@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <01fcd61b-1883-1baa-b0c5-c79b4942ed35@de.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, kvm list <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

Also add David and dri list.....
Short summary, suspend/resume breaks with virtio-gpu as there are no freeze/restore callbacks 
that put the device back into working state.


On 03/13/2018 02:32 PM, Christian Borntraeger wrote:
> 
> 
> On 03/13/2018 01:41 PM, Christian Borntraeger wrote:
>> Gerd,
>>
>> another thing with virtio-gpu.
>>
>> I can successfully do suspend/resume (echo disk > /sys/power/state) on my system. As soon as I have a
>> virtio-gpu the system hangs on reboot/shutdown:
>>
>> e.g.
>>
>> crash> bt 1
>> PID: 1      TASK: 6bef0000          CPU: 4   COMMAND: "systemd"
>>  #0 [6beef4c0] __schedule at a55d60
>>  #1 [6beef530] schedule at a563f2
>>  #2 [6beef548] virtio_gpu_queue_ctrl_buffer_locked at 7ea708
>>  #3 [6beef650] virtio_gpu_queue_ctrl_buffer at 7ea830
>>  #4 [6beef680] virtio_gpu_primary_plane_update at 7ed5ee
>>  #5 [6beef710] drm_atomic_helper_commit_planes at 7a2b46
>>  #6 [6beef760] vgdev_atomic_commit_tail at 7e9dbc
>>  #7 [6beef790] commit_tail at 7a7126
>>  #8 [6beef7c0] drm_atomic_helper_commit at 7a73fe
>>  #9 [6beef800] restore_fbdev_mode_atomic at 7aa38a
>> #10 [6beef8a0] drm_fb_helper_pan_display at 7ab7aa
>> #11 [6beef8f0] fb_pan_display at 74a248
>> #12 [6beef928] bit_update_start at 7573c0
>> #13 [6beef958] fbcon_switch at 7542b4
>> #14 [6beefa50] redraw_screen at 77b2b8
>> #15 [6beefaa0] csi_J at 77b476
>> #16 [6beefad8] do_con_trol at 77ee12
>> #17 [6beefb40] do_con_write at 77f80c
>> #18 [6beefc10] con_write at 78003c
>> #19 [6beefc40] n_tty_write at 7662d4
>> #20 [6beefce0] tty_write at 761734
>> #21 [6beefd48] __vfs_write at 3483cc
>> #22 [6beefe00] vfs_write at 3486e8
>> #23 [6beefe60] sys_write at 3489de
>> #24 [6beefea8] system_call at a5b6a8
>>  PSW:  0705100180000000 000003ff8111251c (user space)
>>  GPRS: 0000000000000000 000003ff00000002 000000000000000e 000003ff80deaef0 
>>        000000000000000a 0000000000000000 000000000000000f 00000000000003ef 
>>        0000000000000000 000000000000000e 000003ff80deaef0 000000000000000a 
>>        000003ff81228f58 000000000000000e 000003ff81112510 000003fffdefedf8 
>>
>>
>>
>>
>> Turns out that the virtio-gpu console (via vnc) prints the image loading but then
>> stops and show no login prompt. (but agetty is running on tty1) So I assume it 
>> already hangs after resume (and I am working on the serial sclp console).
>>
>> Does suspend resume works for you with virtio-gpu on x86? If yes, then I would
>> now look into the s390 code (virtio-blk and net seems to work fine). Otherwise
>> it would be good if you could have a look.
> 
> I just checked. It seems that virtio-gpu has no freeze/restore callbacks. Is there
> some work planned to implement the power callbacks for virtio-gpu?
> 
